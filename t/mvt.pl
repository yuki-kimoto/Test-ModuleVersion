use strict;
use warnings;

use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->exclude([qw/TimeDate Perl Mail/]);
$tm->show_lack_module_url(1);
print $tm->test_script;

