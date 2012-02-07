use Test::More tests => 6;
use strict;
use warnings;
use ExtUtils::Installed;

my $command = shift;
die qq/command "$command" is not found/
  if defined $command && ($command ne 'list_need' && $command ne 'list_all');

if (defined $command) {
  my $builder = Test::More->builder;
  my $out_fh;
  open $out_fh, '>', undef;
  $builder->output($out_fh);
  $builder->failure_output($out_fh);
  $builder->todo_output($out_fh);
}

eval "require Test::ModuleVersion";
die "Test::ModuleVersion loading fail: $@" if $@;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  is($got, $expected, "$module version: $expected");
}

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
