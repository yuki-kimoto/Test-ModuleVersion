package Test::ModuleVersion;
use Object::Simple -base;
use ExtUtils::Installed;

our $VERSION = '0.01';

use 5.008;
use strict;
use warnings;

has exclude => sub { [] };

sub test_script {
  my $self = shift;
  
  my $ei = ExtUtils::Installed->new;
  my @modules = $ei->modules;
  
  my $code = <<'EOS';
use Test::More 'no_plan';
use strict;
use warnings;
use ExtUtils::Installed;

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  
  is($got, $expected, "$module version is $got, but expected is $expected");
}

EOS
  
  for my $module (sort @modules) {
    next if grep { $module eq $_ } @{$self->exclude};
    my $version = $ei->version($module);
    $code .= "use_ok('$module')\n"
      . "module_version_is('$module', \$ei->version('$module'), '$version')\n\n";
  }
  
  return $code;
}

1;

=head1 NAME

Test::ModuleVersion - odule Version Test Generator

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
