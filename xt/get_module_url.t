use Test::More 'no_plan';
use strict;
use warnings;

use Test::ModuleVersion;
my $url = Test::ModuleVersion::get_module_url('Object::Simple', '0.0201');
like($url, qr/http.*Object-Simple-0.0201/);

1;

