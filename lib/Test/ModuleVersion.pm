package Test::ModuleVersion;
use Object::Simple -base;
use 5.008001;
use ExtUtils::Installed;
use HTTP::Tiny;
use JSON 'decode_json';

our $VERSION = '0.04';

has default_ignore => sub { ['Perl', 'Test::ModuleVersion'] };
has ignore => sub { [] };
has lib => sub { [] };
has modules => sub { [] };

sub detect {
  my $self = shift;
  
  # Detect installed modules
  my $ei = ExtUtils::Installed->new;
  my $modules = [];
  push @$modules, [$_ => $ei->version($_)] for sort $ei->modules;
  $self->modules($modules);
  
  return $self;
}

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
  
  # Start test code
  my $code = <<'EOS';
use strict;
use warnings;
use ExtUtils::Installed;
use FindBin;
EOS
  
  $code .= qq|use lib "\$FindBin::Bin/$_";\n| for @{$self->lib};

  $code .= <<'EOS';

my $command = shift;
die qq/command "$command" is not found/
  if defined $command && ($command ne 'list_need' && $command ne 'list_all');

if (defined $command) {
  my $builder = Test::More->builder;
  open my $out_fh, '>', undef;
  $builder->output($out_fh);
  $builder->failure_output($out_fh);
  $builder->todo_output($out_fh);
}

eval "require Test::ModuleVersion";
die "Test::ModuleVersion loading fail: $@" if $@;

my $modules = [];
my $failed = [];
my $require_ok;
my $version_ok;
my $version;

EOS
  
  my $test_count = 0;
  for my $m (@{$self->modules}) {
    my ($module, $version) = @$m;
    next if grep { $module eq $_ } @{$self->default_ignore};
    next if grep { $module eq $_ } @{$self->ignore};
    $code .= "# $module\n"
      . "\$require_ok = require_ok('$module');\n"
      . "\$version_ok = is(\$${module}::VERSION, '$version', '$module version: $version');\n"
      . "push \@\$modules, ['$module' => '$version'];\n"
      . "push \@\$failed, ['$module' => '$version'] unless \$require_ok && \$version_ok;\n\n";
    $test_count += 2;
  }
  
  $code .= <<'EOS';
# Print module URLs
if (defined $command) {
  my @ms = $command eq 'list_need' ? @$failed
    : $command eq 'list_all' ? @$modules
    : undef;
  for my $m (@ms) {
    my ($module, $version) = @$m;
    my $url = Test::ModuleVersion::get_module_url($module, $version);
    if (defined $url) { print "$url\n" }
    else { print STDERR "$module $version is unknown" }
  }  
}
EOS
  
  # Test count
  $code = "use Test::More tests => $test_count;\n" . $code;
  
  return $code;
}

1;

=head1 NAME

Test::ModuleVersion - Module Version Test Generator (EXPERIMENTAL)

=head1 SYNOPSIS

  use Test::ModuleVersion;
  
  # Manually
  my $tm = Test::ModuleVersion->new;
  $tm->modules([
    ['DBIx::Custom' => '0.2108'],
    ['Validator::Custom' => '0.1426']
  ]);
  print $tm->test_script;

  # Automatically
  my $tm = Test::ModuleVersion->new;
  $tm->ignore([qw/Devel::NYTProf MySQL::Diff/]);
  $tm->detect;
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

L<Test::ModuleVersion> create version checking test manually
or automatically

This is C<manually> eamples.

  my $tm = Test::ModuleVersion->new;
  $tm->modules([
    ['DBIx::Custom' => '0.2108'],
    ['Validator::Custom' => '0.1426']
  ]);
  print $tm->test_script;

You set C<modules> attribute which is list of module name and version number.
You can get module test script by C<test_script> method.

run this script(name is C<mvt.pl>) to create test.

 $ perl mvt.pl > t/module.t

the following-like test is created.

    require_ok('DBIx::Custom');
    module_version_is('DBIx::Custom', ExtUtils::Installed->version('DBIx::Custom'), '0.2108');

    require_ok('Validator::Custom');
    module_version_is('Validator::Custom', ExtUtils::Installed->version('Validator::Custom'), '0.1426');

Or you can create module test C<automatically>.

  my $tm = Test::ModuleVersion->new;
  $tm->ignore([qw/Devel::NYTProf MySQL::Diff/]);
  $tm->detect;
  print $tm->test_script;

C<ignore> attribute is set to modules you want to ignore.
C<detect> method detect all installed module and C<modules> attribute is set properly.

=head2 Run test in C<production> environment.

Second, the test script is moved to C<production> environment,
and run the test.

  perl t/module.t

If the version in C<production> environment is different from C<development> one,
test will fail.

  ok 1 - require DBIx::Custom;
  not ok 2 - DBIx::Custom version: 0.2108
  #   Failed test 'DBIx::Custom version: 0.2108'
  #   at module.t.pl line 13.
  #          got: '0.2106'
  #     expected: '0.2108'

  ok 2 - require Validator::Custom;
  ok 3 - Validator::Custom version: 0.1426

It is very useful because you can know the module differnce.

=head2 Get module URLs

If test fail, you install the module manually, it is very hard work.
you can get lacking module URLs by C<list_need> command.

  $ perl module.t list_need

The output is the following-like one.

  http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  ...

Internally, metaCPAN api is used to get module URL.
User Agent is L<HTTP::Tiny>. if you have proxy server,
you can set $ENV{http_proxy}.

Installation using C<cpanm> is very easy.

  $ perl module.t list_need | cpanm

You can also print all modules in test by C<list_all> command.

  $ perl module.t list_all

Have a fun to use L<Test::ModuleVersion>.

=head1 ATTRIBUTES

=head2 C<lib>

  my $lib = $self->lib;
  $tm = $tm->lib(['extlib/lib/perl5']);

Module including pass from script directory.
The following code is added to test script.

  use lib "$FindBin::Bin/extlib/lib/perl5";

If the module is installed in this directory,
module version test is success.

=head2 C<ignore>

  my $ignored_modules = $tm->ignore;
  $tm = $tm->ignore([qw/Devel::NYTProf MySQL::Diff/]);

ignored modules you don't want to contain in test script.

=head2 C<default_ignore>

  my $ignored_modules = $tm->ignore;
  $tm = $tm->ignore(['Perl', 'Test::ModuleVersion']);

Default ignored modules you don't want to contain in test script,
default to C<['Perl']>.

Don't use C<exculde_default> attribute usually.
use C<ignore> attribute instead.

=head2 C<modules>

  my $modules = $tm->modules;
  $tm = $tm->modules($modules);

List of Module name and version.

  $tm->modules([
    ['DBIx::Custom' => '0.2108'],
    ['Validator::Custom' => '0.1426']
  ]);

Version number must be string like C<'0.1426'>, not C<0.1426>.

If C<detect> method is executed, C<modules> attribute is set automatically.

=head1 METHODS

L<DBIx::Custom> inherits all methods from L<Object::Simple>
and implements the following new ones.

=head2 C<detect>

  $tm->detect;

Detect all installed module and C<modules> attribute is set.

=head2 C<get_module_url>

  my $url = $tm->get_module_url($module, $version);

Get module URL by module name and version number.
  
  # http://cpan.metacpan.org/authors/id/K/KI/KIMOTO/DBIx-Custom-0.2108.tar.gz
  my $url = $tm->get_module_url('DBIx::Custom', '0.2108');

You must specify version number as string, not number.
for example, I<0.2110> is wrong, I<'0.2110'> is right.

=head2 C<test_script>

  print $tm->test_script;

Test script which contains module version tests.
C<modules> attirubtes is used to create test script.

=head1 AUTHOR

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Yuki Kimoto.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
