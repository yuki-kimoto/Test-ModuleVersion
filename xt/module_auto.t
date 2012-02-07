use Test::More tests => 72;
use strict;
use warnings;
use ExtUtils::Installed;
use FindBin;

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

# AnyEvent
$require_ok = require_ok('AnyEvent');
$version_ok = is($AnyEvent::VERSION, '6.13', 'AnyEvent version: 6.13');
push @$modules, ['AnyEvent' => '6.13'];
push @$failed, ['AnyEvent' => '6.13'] unless $require_ok && $version_ok;

# DBD::Oracle
$require_ok = require_ok('DBD::Oracle');
$version_ok = is($DBD::Oracle::VERSION, '1.38', 'DBD::Oracle version: 1.38');
push @$modules, ['DBD::Oracle' => '1.38'];
push @$failed, ['DBD::Oracle' => '1.38'] unless $require_ok && $version_ok;

# DBD::Pg
$require_ok = require_ok('DBD::Pg');
$version_ok = is($DBD::Pg::VERSION, '2.18.1', 'DBD::Pg version: 2.18.1');
push @$modules, ['DBD::Pg' => '2.18.1'];
push @$failed, ['DBD::Pg' => '2.18.1'] unless $require_ok && $version_ok;

# DBD::SQLite
$require_ok = require_ok('DBD::SQLite');
$version_ok = is($DBD::SQLite::VERSION, '1.35', 'DBD::SQLite version: 1.35');
push @$modules, ['DBD::SQLite' => '1.35'];
push @$failed, ['DBD::SQLite' => '1.35'] unless $require_ok && $version_ok;

# DBD::mysql
$require_ok = require_ok('DBD::mysql');
$version_ok = is($DBD::mysql::VERSION, '4.020', 'DBD::mysql version: 4.020');
push @$modules, ['DBD::mysql' => '4.020'];
push @$failed, ['DBD::mysql' => '4.020'] unless $require_ok && $version_ok;

# DBI
$require_ok = require_ok('DBI');
$version_ok = is($DBI::VERSION, '1.616', 'DBI version: 1.616');
push @$modules, ['DBI' => '1.616'];
push @$failed, ['DBI' => '1.616'] unless $require_ok && $version_ok;

# DBIx::Connector
$require_ok = require_ok('DBIx::Connector');
$version_ok = is($DBIx::Connector::VERSION, '0.47', 'DBIx::Connector version: 0.47');
push @$modules, ['DBIx::Connector' => '0.47'];
push @$failed, ['DBIx::Connector' => '0.47'] unless $require_ok && $version_ok;

# DBIx::Custom
$require_ok = require_ok('DBIx::Custom');
$version_ok = is($DBIx::Custom::VERSION, '0.2108', 'DBIx::Custom version: 0.2108');
push @$modules, ['DBIx::Custom' => '0.2108'];
push @$failed, ['DBIx::Custom' => '0.2108'] unless $require_ok && $version_ok;

# EV
$require_ok = require_ok('EV');
$version_ok = is($EV::VERSION, '4.10', 'EV version: 4.10');
push @$modules, ['EV' => '4.10'];
push @$failed, ['EV' => '4.10'] unless $require_ok && $version_ok;

# Email::Valid
$require_ok = require_ok('Email::Valid');
$version_ok = is($Email::Valid::VERSION, '0.185', 'Email::Valid version: 0.185');
push @$modules, ['Email::Valid' => '0.185'];
push @$failed, ['Email::Valid' => '0.185'] unless $require_ok && $version_ok;

# Email::Valid::Loose
$require_ok = require_ok('Email::Valid::Loose');
$version_ok = is($Email::Valid::Loose::VERSION, '0.05', 'Email::Valid::Loose version: 0.05');
push @$modules, ['Email::Valid::Loose' => '0.05'];
push @$failed, ['Email::Valid::Loose' => '0.05'] unless $require_ok && $version_ok;

# Encode::Locale
$require_ok = require_ok('Encode::Locale');
$version_ok = is($Encode::Locale::VERSION, '1.02', 'Encode::Locale version: 1.02');
push @$modules, ['Encode::Locale' => '1.02'];
push @$failed, ['Encode::Locale' => '1.02'] unless $require_ok && $version_ok;

# File::Listing
$require_ok = require_ok('File::Listing');
$version_ok = is($File::Listing::VERSION, '6.03', 'File::Listing version: 6.03');
push @$modules, ['File::Listing' => '6.03'];
push @$failed, ['File::Listing' => '6.03'] unless $require_ok && $version_ok;

# HTML::Parser
$require_ok = require_ok('HTML::Parser');
$version_ok = is($HTML::Parser::VERSION, '3.69', 'HTML::Parser version: 3.69');
push @$modules, ['HTML::Parser' => '3.69'];
push @$failed, ['HTML::Parser' => '3.69'] unless $require_ok && $version_ok;

# HTML::Tagset
$require_ok = require_ok('HTML::Tagset');
$version_ok = is($HTML::Tagset::VERSION, '3.20', 'HTML::Tagset version: 3.20');
push @$modules, ['HTML::Tagset' => '3.20'];
push @$failed, ['HTML::Tagset' => '3.20'] unless $require_ok && $version_ok;

# HTTP::Cookies
$require_ok = require_ok('HTTP::Cookies');
$version_ok = is($HTTP::Cookies::VERSION, '6.00', 'HTTP::Cookies version: 6.00');
push @$modules, ['HTTP::Cookies' => '6.00'];
push @$failed, ['HTTP::Cookies' => '6.00'] unless $require_ok && $version_ok;

# HTTP::Daemon
$require_ok = require_ok('HTTP::Daemon');
$version_ok = is($HTTP::Daemon::VERSION, '6.00', 'HTTP::Daemon version: 6.00');
push @$modules, ['HTTP::Daemon' => '6.00'];
push @$failed, ['HTTP::Daemon' => '6.00'] unless $require_ok && $version_ok;

# HTTP::Date
$require_ok = require_ok('HTTP::Date');
$version_ok = is($HTTP::Date::VERSION, '6.00', 'HTTP::Date version: 6.00');
push @$modules, ['HTTP::Date' => '6.00'];
push @$failed, ['HTTP::Date' => '6.00'] unless $require_ok && $version_ok;

# HTTP::Lite
$require_ok = require_ok('HTTP::Lite');
$version_ok = is($HTTP::Lite::VERSION, '2.3', 'HTTP::Lite version: 2.3');
push @$modules, ['HTTP::Lite' => '2.3'];
push @$failed, ['HTTP::Lite' => '2.3'] unless $require_ok && $version_ok;

# HTTP::Message
$require_ok = require_ok('HTTP::Message');
$version_ok = is($HTTP::Message::VERSION, '6.02', 'HTTP::Message version: 6.02');
push @$modules, ['HTTP::Message' => '6.02'];
push @$failed, ['HTTP::Message' => '6.02'] unless $require_ok && $version_ok;

# HTTP::Negotiate
$require_ok = require_ok('HTTP::Negotiate');
$version_ok = is($HTTP::Negotiate::VERSION, '6.00', 'HTTP::Negotiate version: 6.00');
push @$modules, ['HTTP::Negotiate' => '6.00'];
push @$failed, ['HTTP::Negotiate' => '6.00'] unless $require_ok && $version_ok;

# HTTP::Tiny
$require_ok = require_ok('HTTP::Tiny');
$version_ok = is($HTTP::Tiny::VERSION, '0.016', 'HTTP::Tiny version: 0.016');
push @$modules, ['HTTP::Tiny' => '0.016'];
push @$failed, ['HTTP::Tiny' => '0.016'] unless $require_ok && $version_ok;

# JSON
$require_ok = require_ok('JSON');
$version_ok = is($JSON::VERSION, '2.53', 'JSON version: 2.53');
push @$modules, ['JSON' => '2.53'];
push @$failed, ['JSON' => '2.53'] unless $require_ok && $version_ok;

# JSON::XS
$require_ok = require_ok('JSON::XS');
$version_ok = is($JSON::XS::VERSION, '2.32', 'JSON::XS version: 2.32');
push @$modules, ['JSON::XS' => '2.32'];
push @$failed, ['JSON::XS' => '2.32'] unless $require_ok && $version_ok;

# LWP::MediaTypes
$require_ok = require_ok('LWP::MediaTypes');
$version_ok = is($LWP::MediaTypes::VERSION, '6.01', 'LWP::MediaTypes version: 6.01');
push @$modules, ['LWP::MediaTypes' => '6.01'];
push @$failed, ['LWP::MediaTypes' => '6.01'] unless $require_ok && $version_ok;

# Module::Starter
$require_ok = require_ok('Module::Starter');
$version_ok = is($Module::Starter::VERSION, '1.58', 'Module::Starter version: 1.58');
push @$modules, ['Module::Starter' => '1.58'];
push @$failed, ['Module::Starter' => '1.58'] unless $require_ok && $version_ok;

# Mojolicious
$require_ok = require_ok('Mojolicious');
$version_ok = is($Mojolicious::VERSION, '2.46', 'Mojolicious version: 2.46');
push @$modules, ['Mojolicious' => '2.46'];
push @$failed, ['Mojolicious' => '2.46'] unless $require_ok && $version_ok;

# Net::HTTP
$require_ok = require_ok('Net::HTTP');
$version_ok = is($Net::HTTP::VERSION, '6.02', 'Net::HTTP version: 6.02');
push @$modules, ['Net::HTTP' => '6.02'];
push @$failed, ['Net::HTTP' => '6.02'] unless $require_ok && $version_ok;

# Object::Simple
$require_ok = require_ok('Object::Simple');
$version_ok = is($Object::Simple::VERSION, '3.0625', 'Object::Simple version: 3.0625');
push @$modules, ['Object::Simple' => '3.0625'];
push @$failed, ['Object::Simple' => '3.0625'] unless $require_ok && $version_ok;

# Path::Class
$require_ok = require_ok('Path::Class');
$version_ok = is($Path::Class::VERSION, '0.24', 'Path::Class version: 0.24');
push @$modules, ['Path::Class' => '0.24'];
push @$failed, ['Path::Class' => '0.24'] unless $require_ok && $version_ok;

# Test::MockModule
$require_ok = require_ok('Test::MockModule');
$version_ok = is($Test::MockModule::VERSION, '0.05', 'Test::MockModule version: 0.05');
push @$modules, ['Test::MockModule' => '0.05'];
push @$failed, ['Test::MockModule' => '0.05'] unless $require_ok && $version_ok;

# Test::Pod
$require_ok = require_ok('Test::Pod');
$version_ok = is($Test::Pod::VERSION, '1.45', 'Test::Pod version: 1.45');
push @$modules, ['Test::Pod' => '1.45'];
push @$failed, ['Test::Pod' => '1.45'] unless $require_ok && $version_ok;

# URI
$require_ok = require_ok('URI');
$version_ok = is($URI::VERSION, '1.59', 'URI version: 1.59');
push @$modules, ['URI' => '1.59'];
push @$failed, ['URI' => '1.59'] unless $require_ok && $version_ok;

# Validator::Custom
$require_ok = require_ok('Validator::Custom');
$version_ok = is($Validator::Custom::VERSION, '0.1426', 'Validator::Custom version: 0.1426');
push @$modules, ['Validator::Custom' => '0.1426'];
push @$failed, ['Validator::Custom' => '0.1426'] unless $require_ok && $version_ok;

# WWW::RobotRules
$require_ok = require_ok('WWW::RobotRules');
$version_ok = is($WWW::RobotRules::VERSION, '6.01', 'WWW::RobotRules version: 6.01');
push @$modules, ['WWW::RobotRules' => '6.01'];
push @$failed, ['WWW::RobotRules' => '6.01'] unless $require_ok && $version_ok;

# common::sense
$require_ok = require_ok('common::sense');
$version_ok = is($common::sense::VERSION, '3.4', 'common::sense version: 3.4');
push @$modules, ['common::sense' => '3.4'];
push @$failed, ['common::sense' => '3.4'] unless $require_ok && $version_ok;

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
