use Test::More 'no_plan';
use strict;
use warnings;

use Test::ModuleVersion;

my $tm = Test::ModuleVersion->new;
$tm->ignore([qw/TimeDate Perl Mail/]);
$tm->detect;
ok($tm->test_script);

$tm->modules([
  ['DBIx::Custom' => '1.01']
]);
like($tm->test_script, qr/DBIx::Custom.*1.01/);

1;
