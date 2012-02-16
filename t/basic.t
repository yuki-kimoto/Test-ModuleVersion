use Test::More 'no_plan';
use strict;
use warnings;
use Test::ModuleVersion;

sub normalize {
  my $string = shift;
  $string =~ s/\x0D\x0A|\x0D|\x0A/\n/g;
  $string = quotemeta $string;
  return $string;
}

{
  my $tm = Test::ModuleVersion->new;
  $tm->detect;
  ok($tm->test_script);
}
{
  my $tm = Test::ModuleVersion->new;
  $tm->modules([
    ['DBIx::Custom' => '1.01']
  ]);
  like($tm->test_script, qr/DBIx::Custom.*1.01/);
}
{
  my $tm = Test::ModuleVersion->new;
  $tm->lib(['extlib/lib/perl5']);
  $tm->modules([
    ['Object::Simple' => '3.0624'],
    ['DBIx::Custom' => '0.2107'],
    ['Validator::Custom' => '0.1426']
  ]);
  my $test_script = $tm->test_script;
}

1;
