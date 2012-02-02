use Test::More 'no_plan';
use strict;
use warnings;

use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->exclude([qw/TimeDate Perl Mail/]);
my $test_script = $tm->test_script;

1;
