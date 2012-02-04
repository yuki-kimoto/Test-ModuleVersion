package Test::ModuleVersion;
use Object::Simple -base;
use 5.008001;
use ExtUtils::Installed;
use HTTP::Tiny;
use JSON 'decode_json';

our $VERSION = '0.02';

has exclude_default => sub { ['Perl', 'Test::ModuleVersion'] };
has exclude => sub { [] };
has show_lack_module_url => 0;

sub get_module_url {
  my ($module, $version) = @_;
  
  # Module
  my $module_dist = $module;
  $module_dist =~ s/::/-/g;
  
  # Get dounload URL using metaCPAN api
  my $metacpan_api = 'http://api.metacpan.org/v0';
  my $search = "release/_search?q=name:$module_dist-$version"
    . "&fields=download_url,name";
  my $http = HTTP::Tiny->new;
  my $res = $http->get("$metacpan_api/$search");
  if ($res->{success}) {
    my $release = decode_json $res->{content};
    return $release->{hits}{hits}[0]{fields}{download_url};
  }
  
  return;
}

sub test_script {
  my $self = shift;
  
  my $ei = ExtUtils::Installed->new;
  my @modules = $ei->modules;
  
  my $code = <<'EOS';
use Test::More 'no_plan';
use strict;
use warnings;
use ExtUtils::Installed;

my $command = shift;
die qq/command "$command" is not found/
  if defined $command && $command ne 'install_list';

if (defined $command) {
  my $builder = Test::More->builder;
  my $out_fh;
  open $out_fh, '>', undef;
  $builder->output($out_fh);
  $builder->failure_output($out_fh);
  $builder->todo_output($out_fh);
}

eval "require Test::ModuleVersion";
die "Test::ModuleVersion loading fail: $@" if $@;

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  is($got, $expected, "$module version: $expected");
}

my $failed = {};
my $require_ok;
my $version_ok;
my $version;

EOS
  
  for my $module (sort @modules) {
    next if grep { $module eq $_ } @{$self->exclude_default};
    next if grep { $module eq $_ } @{$self->exclude};
    my $version = $ei->version($module);
    $code .= "# $module\n"
      . "\$require_ok = require_ok('$module');\n"
      . "\$version = '';\n"
      . "eval { \$version = \$ei->version('$module') };\n"
      . "\$version_ok = module_version_is('$module', \$version, '$version');\n"
      . "\$failed->{'$module'} = {version => '$version'} unless \$require_ok && \$version_ok;\n\n";
  }
  
  if ($self->show_lack_module_url) {
    $code .= <<'EOS';
# Print module URLs
if (my @modules = sort keys %$failed) {
  print "# Lacking module URLs\n" unless defined $command;
  for my $module (@modules) {
    my $version = $failed->{$module}{version};
    my $url = Test::ModuleVersion::get_module_url($module, $version);
    if (defined $command && $command eq 'install_list') {
      print "$url\n" if defined $url
    }
    else {
      my $output = defined $url ? "# $url" : "# $module $version is unknown";
      print "$output\n";
    }
  }
}
EOS
  }
  
  return $code;
}

1;

=head1 NAME

Test::ModuleVersion - Module Version Test Generator (experimental stage)

=head1 SYNOPSIS

  my $tm = Test::ModuleVersion->new;
  $tm->exclude([qw/Devel::NYTProf MySQL::Diff/]);
  $tm->show_lack_module_url(1);
  print $tm->test_script;

=head1 DESCRIPTION

It is very difficult to install same modules in development
environment and production environment.

C<cpan> is single versioning system, so you can't install
specified version module well.

Installation is very hard work if therer many modules.
L<Test::ModuleVersion> help you.

=head2 Create version checking test in C<development> environment.

At first, you create test script in C<development> environment.

L<Test::ModuleVersion> create version checking test automatically
by C<test_script> method.

  my $tm = Test::ModuleVersion->new;
  print $tm->test_script;

Using this script(name is C<mvt.pl>), you create test.

 $ perl mvt.pl > t/module.t

Briefly writting, the following-like test is created.

    require_ok('DBIx::Custom');
    module_version_is('DBIx::Custom', ExtUtils::Installed->version('DBIx::Custom'), '0.2108');

=head2 Run test in <production> environment.

Second, the test script is moved to C<production> environment,
and run the test.

  perl t/module.t

If the version in C<production> environment is different from C<development> one,
test will fail.

  ok 15 - require DBIx::Custom;
  not ok 16 - DBIx::Custom version: 0.2108
  #   Failed test 'DBIx::Custom version: 0.2108'
  #   at module.t.pl line 13.
  #          got: '0.2106'
  #     expected: '0.2108'

It is very useful because you can know the differnce by test.

=head2 Get module URLs

If test fail, you install the module manually, it is very hard work.
If you set C<show_lack_module_url> to C<1> before C<test_script> call,
you can print module URLs in test script.

  $tm->show_lack_module_url(1);
  print $tm->test_script;

If you run test script, module URLs is printed after test result.

  ok 15 - require DBIx::Custom;
  not ok 16 - DBIx::Custom version: 0.2108
  #   Failed test 'DBIx::Custom version: 0.2108'
  #   at module.t.pl line 13.
  #          got: '0.2106'
  #     expected: '0.2108'
  
  ...
  
  # Lacking module URLs
  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz

You can install module by C<cpanm> easily.

  $ cpanm http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz

You can print only lacking module URLs by C<install_list> argument.

  $ perl module.t install_list

The output is the following-like one.

  http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/Validator-Custom-0.1426.tar.gz

Installation using C<cpanm> is very easy.

  $ perl module.t install_list | cpanm
  $ perl moudle.t install_list | cpanm

If at least two time you exceute the above command,
all modules are maybe installed.

Have a fun to use L<Test::ModuleVersion>.

=head1 ATTRIBUTES

=head2 C<exclude>

  my $excluded_modules = $tm->exclude;
  $tm = $tm->exclude([qw/Devel::NYTProf MySQL::Diff/]);

Excluded modules you don't want to contain in test script.

=head2 C<exclude_default>

  my $excluded_modules = $tm->exclude;
  $tm = $tm->exclude(['Perl', 'Test::ModuleVersion']);

Default excluded modules you don't want to contain in test script,
default to C<['Perl']>.

Don't use C<exculde_default> attribute usually.
use C<exclude> attribute instead.

=head2 C<show_lack_module_url>

  my $show_lack_module_url = $tm->show_lack_module_url;
  $tm = $tm->show_lack_module_url(1);

If this value is true,
C<test_script> contains a logic to show URLs
of module which version test is failed.
Default to C<0>.

You can get the following-like outputs when test script will run.

  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/Validator-Custom-0.1426.tar.gz
  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/Object-Simple-3.0625.tar.gz

This is very useful because you can finish module installation by C<cpanm>

  cpanm http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  cpanm http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/Validator-Custom-0.1426.tar.gz
  cpanm http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/Object-Simple-3.0625.tar.gz

=head1 METHODS

L<DBIx::Custom> inherits all methods from L<Object::Simple>
and implements the following new ones.

=head2 C<test_script>

  print $tm->test_script;

Test script which contains module version tests.

=head2 C<get_module_url>

  my $url = $tm->get_module_url($module, $version);

Get module URL by module name and version number.
  
  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  my $url = $tm->get_module_url('DBIx::Custom', '0.2108');

You must specify version number as string, not number.
for example, I<0.2110> is wrong, I<'0.2110'> is right.

=head1 AUTHOR

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Yuki Kimoto.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
