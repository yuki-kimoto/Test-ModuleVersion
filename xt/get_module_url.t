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
  $tm->distnames({LWP => 'libwww-perl'});
  my $url = $tm->get_module_url('LWP', '6.03');
  like($url, qr/http.*libwww-perl-6.03/);
}


1;

