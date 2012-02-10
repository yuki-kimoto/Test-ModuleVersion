use strict;
use warnings;
use FindBin;
use Test::ModuleVersion;

{
  my $tm = Test::ModuleVersion->new;
  $tm->lib(['extlib/lib/perl5']);
  $tm->modules([
    ['Object::Simple' => '3.0624'],
    ['DBIx::Custom' => '0.2107'],
    ['Validator::Custom' => '0.1426']
  ]);
  open my $fh, '>', "$FindBin::Bin/module.t.pl"
    or die $!;
  print $fh $tm->test_script;
}

{
  my $tm = Test::ModuleVersion->new;
  $tm->ignore([qw/TimeDate Mail/]);
  $tm->detect;
  open my $fh, '>', "$FindBin::Bin/module_auto.t.pl"
    or die $!;
  print $fh $tm->test_script;
}
