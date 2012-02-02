use strict;
use warnings;

use Test::ModuleVersion;

my $failed = {
  'Object::Simple' => {version => '0.0201'},
  'Validator::Custom' => {version => '0.0201'}
};
my $outputs = Test::ModuleVersion::_lack_module_url($failed);

1;

