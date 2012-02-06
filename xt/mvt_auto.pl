use strict;
use warnings;
use FindBin;
use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->ignore([qw/TimeDate Mail/]);
$tm->detect;
open my $fh, '>', "$FindBin::Bin/module_auto.t"
  or die $!;
print $fh $tm->test_script;
