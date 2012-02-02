use Test::More 'no_plan';
use strict;
use warnings;
use ExtUtils::Installed;

my @required = qw/Test::ModuleVersion/;
for my $module (@required) {
  eval "require Test::ModuleVersion";
  die "Test::ModuleVersion loading fail: $@" if $@;
}

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  is($got, $expected, "$module version: $expected");
}

my $failed = {};
my $use_ok;
my $version_ok;

$use_ok = require_ok('AnyEvent');
$version_ok = module_version_is('AnyEvent', $ei->version('AnyEvent'), '6.13');
$failed->{'AnyEvent'} = {version => '6.13'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBD::Oracle');
$version_ok = module_version_is('DBD::Oracle', $ei->version('DBD::Oracle'), '1.38');
$failed->{'DBD::Oracle'} = {version => '1.38'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBD::Pg');
$version_ok = module_version_is('DBD::Pg', $ei->version('DBD::Pg'), '2.18.1');
$failed->{'DBD::Pg'} = {version => '2.18.1'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBD::SQLite');
$version_ok = module_version_is('DBD::SQLite', $ei->version('DBD::SQLite'), '1.35');
$failed->{'DBD::SQLite'} = {version => '1.35'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBD::mysql');
$version_ok = module_version_is('DBD::mysql', $ei->version('DBD::mysql'), '4.020');
$failed->{'DBD::mysql'} = {version => '4.020'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBI');
$version_ok = module_version_is('DBI', $ei->version('DBI'), '1.616');
$failed->{'DBI'} = {version => '1.616'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBIx::Connector');
$version_ok = module_version_is('DBIx::Connector', $ei->version('DBIx::Connector'), '0.47');
$failed->{'DBIx::Connector'} = {version => '0.47'} unless $use_ok && $version_ok;

$use_ok = require_ok('DBIx::Custom');
$version_ok = module_version_is('DBIx::Custom', $ei->version('DBIx::Custom'), '0.2108');
$failed->{'DBIx::Custom'} = {version => '0.2108'} unless $use_ok && $version_ok;

$use_ok = require_ok('EV');
$version_ok = module_version_is('EV', $ei->version('EV'), '4.10');
$failed->{'EV'} = {version => '4.10'} unless $use_ok && $version_ok;

$use_ok = require_ok('Email::Valid');
$version_ok = module_version_is('Email::Valid', $ei->version('Email::Valid'), '0.185');
$failed->{'Email::Valid'} = {version => '0.185'} unless $use_ok && $version_ok;

$use_ok = require_ok('Email::Valid::Loose');
$version_ok = module_version_is('Email::Valid::Loose', $ei->version('Email::Valid::Loose'), '0.05');
$failed->{'Email::Valid::Loose'} = {version => '0.05'} unless $use_ok && $version_ok;

$use_ok = require_ok('Encode::Locale');
$version_ok = module_version_is('Encode::Locale', $ei->version('Encode::Locale'), '1.02');
$failed->{'Encode::Locale'} = {version => '1.02'} unless $use_ok && $version_ok;

$use_ok = require_ok('File::Listing');
$version_ok = module_version_is('File::Listing', $ei->version('File::Listing'), '6.03');
$failed->{'File::Listing'} = {version => '6.03'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTML::Parser');
$version_ok = module_version_is('HTML::Parser', $ei->version('HTML::Parser'), '3.69');
$failed->{'HTML::Parser'} = {version => '3.69'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTML::Tagset');
$version_ok = module_version_is('HTML::Tagset', $ei->version('HTML::Tagset'), '3.20');
$failed->{'HTML::Tagset'} = {version => '3.20'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Cookies');
$version_ok = module_version_is('HTTP::Cookies', $ei->version('HTTP::Cookies'), '6.00');
$failed->{'HTTP::Cookies'} = {version => '6.00'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Daemon');
$version_ok = module_version_is('HTTP::Daemon', $ei->version('HTTP::Daemon'), '6.00');
$failed->{'HTTP::Daemon'} = {version => '6.00'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Date');
$version_ok = module_version_is('HTTP::Date', $ei->version('HTTP::Date'), '6.00');
$failed->{'HTTP::Date'} = {version => '6.00'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Lite');
$version_ok = module_version_is('HTTP::Lite', $ei->version('HTTP::Lite'), '2.3');
$failed->{'HTTP::Lite'} = {version => '2.3'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Message');
$version_ok = module_version_is('HTTP::Message', $ei->version('HTTP::Message'), '6.02');
$failed->{'HTTP::Message'} = {version => '6.02'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Negotiate');
$version_ok = module_version_is('HTTP::Negotiate', $ei->version('HTTP::Negotiate'), '6.00');
$failed->{'HTTP::Negotiate'} = {version => '6.00'} unless $use_ok && $version_ok;

$use_ok = require_ok('HTTP::Tiny');
$version_ok = module_version_is('HTTP::Tiny', $ei->version('HTTP::Tiny'), '0.016');
$failed->{'HTTP::Tiny'} = {version => '0.016'} unless $use_ok && $version_ok;

$use_ok = require_ok('JSON');
$version_ok = module_version_is('JSON', $ei->version('JSON'), '2.53');
$failed->{'JSON'} = {version => '2.53'} unless $use_ok && $version_ok;

$use_ok = require_ok('JSON::XS');
$version_ok = module_version_is('JSON::XS', $ei->version('JSON::XS'), '2.32');
$failed->{'JSON::XS'} = {version => '2.32'} unless $use_ok && $version_ok;

$use_ok = require_ok('LWP::MediaTypes');
$version_ok = module_version_is('LWP::MediaTypes', $ei->version('LWP::MediaTypes'), '6.01');
$failed->{'LWP::MediaTypes'} = {version => '6.01'} unless $use_ok && $version_ok;

$use_ok = require_ok('Module::Starter');
$version_ok = module_version_is('Module::Starter', $ei->version('Module::Starter'), '1.58');
$failed->{'Module::Starter'} = {version => '1.58'} unless $use_ok && $version_ok;

$use_ok = require_ok('Mojolicious');
$version_ok = module_version_is('Mojolicious', $ei->version('Mojolicious'), '2.46');
$failed->{'Mojolicious'} = {version => '2.46'} unless $use_ok && $version_ok;

$use_ok = require_ok('Net::HTTP');
$version_ok = module_version_is('Net::HTTP', $ei->version('Net::HTTP'), '6.02');
$failed->{'Net::HTTP'} = {version => '6.02'} unless $use_ok && $version_ok;

$use_ok = require_ok('Object::Simple');
$version_ok = module_version_is('Object::Simple', $ei->version('Object::Simple'), '3.0625');
$failed->{'Object::Simple'} = {version => '3.0625'} unless $use_ok && $version_ok;

$use_ok = require_ok('Path::Class');
$version_ok = module_version_is('Path::Class', $ei->version('Path::Class'), '0.24');
$failed->{'Path::Class'} = {version => '0.24'} unless $use_ok && $version_ok;

$use_ok = require_ok('Test::MockModule');
$version_ok = module_version_is('Test::MockModule', $ei->version('Test::MockModule'), '0.05');
$failed->{'Test::MockModule'} = {version => '0.05'} unless $use_ok && $version_ok;

$use_ok = require_ok('Test::ModuleVersion');
$version_ok = module_version_is('Test::ModuleVersion', $ei->version('Test::ModuleVersion'), '0.01');
$failed->{'Test::ModuleVersion'} = {version => '0.01'} unless $use_ok && $version_ok;

$use_ok = require_ok('Test::Pod');
$version_ok = module_version_is('Test::Pod', $ei->version('Test::Pod'), '1.45');
$failed->{'Test::Pod'} = {version => '1.45'} unless $use_ok && $version_ok;

$use_ok = require_ok('URI');
$version_ok = module_version_is('URI', $ei->version('URI'), '1.59');
$failed->{'URI'} = {version => '1.59'} unless $use_ok && $version_ok;

$use_ok = require_ok('Validator::Custom');
$version_ok = module_version_is('Validator::Custom', $ei->version('Validator::Custom'), '0.1426');
$failed->{'Validator::Custom'} = {version => '0.1426'} unless $use_ok && $version_ok;

$use_ok = require_ok('WWW::RobotRules');
$version_ok = module_version_is('WWW::RobotRules', $ei->version('WWW::RobotRules'), '6.01');
$failed->{'WWW::RobotRules'} = {version => '6.01'} unless $use_ok && $version_ok;

$use_ok = require_ok('common::sense');
$version_ok = module_version_is('common::sense', $ei->version('common::sense'), '3.4');
$failed->{'common::sense'} = {version => '3.4'} unless $use_ok && $version_ok;

print "# Lacked Module URL\n";
my $outputs = Test::ModuleVersion::_lack_module_url($failed);
print join("\n", @$outputs) . "\n" if @$outputs;
