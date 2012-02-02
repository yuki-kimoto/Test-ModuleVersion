use strict;
use warnings;

use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->exclude([qw/TimeDate Perl Mail/]);
print $tm->test_script;
