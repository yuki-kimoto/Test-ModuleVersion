use strict;
use warnings;
use FindBin;
use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->exclude([qw/TimeDate Mail/]);
$tm->show_lack_module_url(1);
open my $fh, '>', "$FindBin::Bin/module.t"
  or die $!;
print $fh $tm->test_script;
