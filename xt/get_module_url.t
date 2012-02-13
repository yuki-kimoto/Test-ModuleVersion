use Test::More 'no_plan';
use strict;
use warnings;

use Test::ModuleVersion;
{
  my $tm = Test::ModuleVersion->new;
  my $url = $tm->get_module_url('Object::Simple', '0.0201');
  like($url, qr/http.*Object-Simple-0.0201/);
}

{
  my $tm = Test::ModuleVersion->new;
  $tm->distnames({
    'LWP' => 'libwww-perl',
    'IO::Compress::Base' => 'IO-Compress',
    'Cwd' => 'PathTools',
    'File::Spec' => 'PathTools',
    'List::Util' => 'Scalar-List-Utils',
    'Scalar::Util' => 'Scalar-List-Utils'
  });
  my $url = $tm->get_module_url('LWP', '6.03');
  like($url, qr/http.*libwww-perl-6.03/);
  $url = $tm->get_module_url('IO::Compress::Base', '2.048');
  like($url, qr/http.*IO-Compress-2.048/);
  $url = $tm->get_module_url('Cwd', '3.33');
  like($url, qr/http.*PathTools-3.33/);
  $url = $tm->get_module_url('File::Spec', '3.33');
  like($url, qr/http.*PathTools-3.33/);
  $url = $tm->get_module_url('List::Util', '1.23');
  like($url, qr/http.*Scalar-List-Utils-1.23/);
  $url = $tm->get_module_url('Scalar::Util', '1.23');
  like($url, qr/http.*Scalar-List-Utils-1.23/);
}


1;

