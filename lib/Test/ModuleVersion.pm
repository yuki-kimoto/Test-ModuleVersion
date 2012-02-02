package Test::ModuleVersion;
use Object::Simple -base;
use ExtUtils::Installed;
use HTTP::Tiny;
use JSON 'decode_json';

our $VERSION = '0.01';

use 5.008;
use strict;
use warnings;

has exclude => sub { [] };
has show_lack_module_url => 0;

sub _lack_module_url {
  my $failed = shift;

  my $outputs = [];

  # metaCPAN info
  my $http = HTTP::Tiny->new;
  my $metacpan_api = 'http://api.metacpan.org/v0';
  my $metacpan = "http://cpan.metacpan.org";

  # Guess module URL
  for my $module (sort keys %$failed) {

    # Module info
    my $module_dist = $module;
    $module_dist =~ s/::/-/g;
    my $version = $failed->{$module}{version};
    
    # metaCPAN api
    my $res = $http->get("$metacpan_api/release/$module_dist");
    push @$outputs, "# $module url is unknown" and next
      unless $res->{success};
    my $content = $res->{content};

    # Latest release
    my $latest_release = decode_json($content);
    my $author = $latest_release->{author};
    my $index1 = substr $author, 0, 1;
    my $index2 = substr $author, 0, 2;
    
    # metaCPAN archive
    my $module_url = "$metacpan/authors/id/$index1/$index2/"
      . "$author/$module_dist-$version.tar.gz";
    $res = $http->head($module_url);
    if ($res->{success}) { push @$outputs, "# $module_url" }
    else { push @$outputs, "# $module url is unknown" }
  }
  return $outputs;
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

my @required = qw/Test::ModuleVersion/;
for my $module (@required) {
  eval "require Test::ModuleVersion";
  die "Test::ModuleVersion loading fail: $@" if $@;
}

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  is($got, $expected, "$module version: $expected");
}

my $failed = {};
my $use_ok;
my $version_ok;

EOS
  
  for my $module (sort @modules) {
    next if grep { $module eq $_ } @{$self->exclude};
    my $version = $ei->version($module);
    $code .= "\$use_ok = require_ok('$module');\n"
      . "\$version_ok = module_version_is('$module', \$ei->version('$module'), '$version');\n"
      . "\$failed->{'$module'} = {version => '$version'} unless \$use_ok && \$version_ok;\n\n";
  }
  
  if ($self->show_lack_module_url) {
    $code .= <<'EOS';
print "# Lacked Module URL \n";
my $outputs = Test::ModuleVersion::_lack_module_url($failed);
print join("\n", @$outputs) . "\n" if @$outputs;
EOS
  }
  
  return $code;
}

1;

=head1 NAME

Test::ModuleVersion - Module Version Test Generator

=head1 SYNOPSIS

  my $tm = Test::ModuleVersion->new;
  print $tm->test_script;

=head1 AUTHOR

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Yuki Kimoto.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
