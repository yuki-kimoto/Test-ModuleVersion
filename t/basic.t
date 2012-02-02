use Test::More 'no_plan';
use strict;
use warnings;

use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->exclude([qw/TimeDate Perl Mail/]);
$tm->show_lack_module_url(1);
my $test_script = $tm->test_script;
ok($test_script);

1;
