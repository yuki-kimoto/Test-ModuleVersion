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
  $tm->ignore([qw/TimeDate Perl Mail/]);
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
  $test_script =~ s/\x0D\x0A|\x0D|\x0A/\n/g;
  
  my $code = <<'EOS';
use Test::More tests => 6;
use strict;
use warnings;
use ExtUtils::Installed;
use FindBin;
use lib "$FindBin::Bin/extlib/lib/perl5";

my $command = shift;
die qq/command "$command" is not found/
  if defined $command && ($command ne 'list_need' && $command ne 'list_all');

if (defined $command) {
  my $builder = Test::More->builder;
  open my $out_fh, '>', undef;
  $builder->output($out_fh);
  $builder->failure_output($out_fh);
  $builder->todo_output($out_fh);
}

eval "require Test::ModuleVersion";
die "Test::ModuleVersion loading fail: $@" if $@;

my $modules = [];
my $failed = [];
my $require_ok;
my $version_ok;
my $version;

# Object::Simple
$require_ok = require_ok('Object::Simple');
$version_ok = is($Object::Simple::VERSION, '3.0624', 'Object::Simple version: 3.0624');
push @$modules, ['Object::Simple' => '3.0624'];
push @$failed, ['Object::Simple' => '3.0624'] unless $require_ok && $version_ok;

# DBIx::Custom
$require_ok = require_ok('DBIx::Custom');
$version_ok = is($DBIx::Custom::VERSION, '0.2107', 'DBIx::Custom version: 0.2107');
push @$modules, ['DBIx::Custom' => '0.2107'];
push @$failed, ['DBIx::Custom' => '0.2107'] unless $require_ok && $version_ok;

# Validator::Custom
$require_ok = require_ok('Validator::Custom');
$version_ok = is($Validator::Custom::VERSION, '0.1426', 'Validator::Custom version: 0.1426');
push @$modules, ['Validator::Custom' => '0.1426'];
push @$failed, ['Validator::Custom' => '0.1426'] unless $require_ok && $version_ok;

# Print module URLs
if (defined $command) {
  my @ms = $command eq 'list_need' ? @$failed
    : $command eq 'list_all' ? @$modules
    : undef;
  for my $m (@ms) {
    my ($module, $version) = @$m;
    my $url = Test::ModuleVersion::get_module_url($module, $version);
    if (defined $url) { print "$url\n" }
    else { print STDERR "$module $version is unknown" }
  }  
}
EOS
  
  $code =~ s/\x0D\x0A|\x0D|\x0A/\n/g;
  is($test_script, $code);
}

1;
