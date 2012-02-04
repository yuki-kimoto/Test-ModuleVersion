use Test::More 'no_plan';
use strict;
use warnings;
use ExtUtils::Installed;

my $command = shift;
die qq/command "$command" is not found/
  if defined $command && $command ne 'install_list';

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

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  is($got, $expected, "$module version: $expected");
}

my $failed = {};
my $require_ok;
my $version_ok;
my $version;

# AnyEvent
$require_ok = require_ok('AnyEvent');
$version = '';
eval { $version = $ei->version('AnyEvent') };
$version_ok = module_version_is('AnyEvent', $version, '6.13');
$failed->{'AnyEvent'} = {version => '6.13'} unless $require_ok && $version_ok;

# DBD::Oracle
$require_ok = require_ok('DBD::Oracle');
$version = '';
eval { $version = $ei->version('DBD::Oracle') };
$version_ok = module_version_is('DBD::Oracle', $version, '1.38');
$failed->{'DBD::Oracle'} = {version => '1.38'} unless $require_ok && $version_ok;

# DBD::Pg
$require_ok = require_ok('DBD::Pg');
$version = '';
eval { $version = $ei->version('DBD::Pg') };
$version_ok = module_version_is('DBD::Pg', $version, '2.18.1');
$failed->{'DBD::Pg'} = {version => '2.18.1'} unless $require_ok && $version_ok;

# DBD::SQLite
$require_ok = require_ok('DBD::SQLite');
$version = '';
eval { $version = $ei->version('DBD::SQLite') };
$version_ok = module_version_is('DBD::SQLite', $version, '1.35');
$failed->{'DBD::SQLite'} = {version => '1.35'} unless $require_ok && $version_ok;

# DBD::mysql
$require_ok = require_ok('DBD::mysql');
$version = '';
eval { $version = $ei->version('DBD::mysql') };
$version_ok = module_version_is('DBD::mysql', $version, '4.020');
$failed->{'DBD::mysql'} = {version => '4.020'} unless $require_ok && $version_ok;

# DBI
$require_ok = require_ok('DBI');
$version = '';
eval { $version = $ei->version('DBI') };
$version_ok = module_version_is('DBI', $version, '1.616');
$failed->{'DBI'} = {version => '1.616'} unless $require_ok && $version_ok;

# DBIx::Connector
$require_ok = require_ok('DBIx::Connector');
$version = '';
eval { $version = $ei->version('DBIx::Connector') };
$version_ok = module_version_is('DBIx::Connector', $version, '0.47');
$failed->{'DBIx::Connector'} = {version => '0.47'} unless $require_ok && $version_ok;

# DBIx::Custom
$require_ok = require_ok('DBIx::Custom');
$version = '';
eval { $version = $ei->version('DBIx::Custom') };
$version_ok = module_version_is('DBIx::Custom', $version, '0.2108');
$failed->{'DBIx::Custom'} = {version => '0.2108'} unless $require_ok && $version_ok;

# EV
$require_ok = require_ok('EV');
$version = '';
eval { $version = $ei->version('EV') };
$version_ok = module_version_is('EV', $version, '4.10');
$failed->{'EV'} = {version => '4.10'} unless $require_ok && $version_ok;

# Email::Valid
$require_ok = require_ok('Email::Valid');
$version = '';
eval { $version = $ei->version('Email::Valid') };
$version_ok = module_version_is('Email::Valid', $version, '0.185');
$failed->{'Email::Valid'} = {version => '0.185'} unless $require_ok && $version_ok;

# Email::Valid::Loose
$require_ok = require_ok('Email::Valid::Loose');
$version = '';
eval { $version = $ei->version('Email::Valid::Loose') };
$version_ok = module_version_is('Email::Valid::Loose', $version, '0.05');
$failed->{'Email::Valid::Loose'} = {version => '0.05'} unless $require_ok && $version_ok;

# Encode::Locale
$require_ok = require_ok('Encode::Locale');
$version = '';
eval { $version = $ei->version('Encode::Locale') };
$version_ok = module_version_is('Encode::Locale', $version, '1.02');
$failed->{'Encode::Locale'} = {version => '1.02'} unless $require_ok && $version_ok;

# File::Listing
$require_ok = require_ok('File::Listing');
$version = '';
eval { $version = $ei->version('File::Listing') };
$version_ok = module_version_is('File::Listing', $version, '6.03');
$failed->{'File::Listing'} = {version => '6.03'} unless $require_ok && $version_ok;

# HTML::Parser
$require_ok = require_ok('HTML::Parser');
$version = '';
eval { $version = $ei->version('HTML::Parser') };
$version_ok = module_version_is('HTML::Parser', $version, '3.69');
$failed->{'HTML::Parser'} = {version => '3.69'} unless $require_ok && $version_ok;

# HTML::Tagset
$require_ok = require_ok('HTML::Tagset');
$version = '';
eval { $version = $ei->version('HTML::Tagset') };
$version_ok = module_version_is('HTML::Tagset', $version, '3.20');
$failed->{'HTML::Tagset'} = {version => '3.20'} unless $require_ok && $version_ok;

# HTTP::Cookies
$require_ok = require_ok('HTTP::Cookies');
$version = '';
eval { $version = $ei->version('HTTP::Cookies') };
$version_ok = module_version_is('HTTP::Cookies', $version, '6.00');
$failed->{'HTTP::Cookies'} = {version => '6.00'} unless $require_ok && $version_ok;

# HTTP::Daemon
$require_ok = require_ok('HTTP::Daemon');
$version = '';
eval { $version = $ei->version('HTTP::Daemon') };
$version_ok = module_version_is('HTTP::Daemon', $version, '6.00');
$failed->{'HTTP::Daemon'} = {version => '6.00'} unless $require_ok && $version_ok;

# HTTP::Date
$require_ok = require_ok('HTTP::Date');
$version = '';
eval { $version = $ei->version('HTTP::Date') };
$version_ok = module_version_is('HTTP::Date', $version, '6.00');
$failed->{'HTTP::Date'} = {version => '6.00'} unless $require_ok && $version_ok;

# HTTP::Lite
$require_ok = require_ok('HTTP::Lite');
$version = '';
eval { $version = $ei->version('HTTP::Lite') };
$version_ok = module_version_is('HTTP::Lite', $version, '2.3');
$failed->{'HTTP::Lite'} = {version => '2.3'} unless $require_ok && $version_ok;

# HTTP::Message
$require_ok = require_ok('HTTP::Message');
$version = '';
eval { $version = $ei->version('HTTP::Message') };
$version_ok = module_version_is('HTTP::Message', $version, '6.02');
$failed->{'HTTP::Message'} = {version => '6.02'} unless $require_ok && $version_ok;

# HTTP::Negotiate
$require_ok = require_ok('HTTP::Negotiate');
$version = '';
eval { $version = $ei->version('HTTP::Negotiate') };
$version_ok = module_version_is('HTTP::Negotiate', $version, '6.00');
$failed->{'HTTP::Negotiate'} = {version => '6.00'} unless $require_ok && $version_ok;

# HTTP::Tiny
$require_ok = require_ok('HTTP::Tiny');
$version = '';
eval { $version = $ei->version('HTTP::Tiny') };
$version_ok = module_version_is('HTTP::Tiny', $version, '0.016');
$failed->{'HTTP::Tiny'} = {version => '0.016'} unless $require_ok && $version_ok;

# JSON
$require_ok = require_ok('JSON');
$version = '';
eval { $version = $ei->version('JSON') };
$version_ok = module_version_is('JSON', $version, '2.53');
$failed->{'JSON'} = {version => '2.53'} unless $require_ok && $version_ok;

# JSON::XS
$require_ok = require_ok('JSON::XS');
$version = '';
eval { $version = $ei->version('JSON::XS') };
$version_ok = module_version_is('JSON::XS', $version, '2.32');
$failed->{'JSON::XS'} = {version => '2.32'} unless $require_ok && $version_ok;

# LWP::MediaTypes
$require_ok = require_ok('LWP::MediaTypes');
$version = '';
eval { $version = $ei->version('LWP::MediaTypes') };
$version_ok = module_version_is('LWP::MediaTypes', $version, '6.01');
$failed->{'LWP::MediaTypes'} = {version => '6.01'} unless $require_ok && $version_ok;

# Module::Starter
$require_ok = require_ok('Module::Starter');
$version = '';
eval { $version = $ei->version('Module::Starter') };
$version_ok = module_version_is('Module::Starter', $version, '1.58');
$failed->{'Module::Starter'} = {version => '1.58'} unless $require_ok && $version_ok;

# Mojolicious
$require_ok = require_ok('Mojolicious');
$version = '';
eval { $version = $ei->version('Mojolicious') };
$version_ok = module_version_is('Mojolicious', $version, '2.46');
$failed->{'Mojolicious'} = {version => '2.46'} unless $require_ok && $version_ok;

# Net::HTTP
$require_ok = require_ok('Net::HTTP');
$version = '';
eval { $version = $ei->version('Net::HTTP') };
$version_ok = module_version_is('Net::HTTP', $version, '6.02');
$failed->{'Net::HTTP'} = {version => '6.02'} unless $require_ok && $version_ok;

# Object::Simple
$require_ok = require_ok('Object::Simple');
$version = '';
eval { $version = $ei->version('Object::Simple') };
$version_ok = module_version_is('Object::Simple', $version, '3.0625');
$failed->{'Object::Simple'} = {version => '3.0625'} unless $require_ok && $version_ok;

# Path::Class
$require_ok = require_ok('Path::Class');
$version = '';
eval { $version = $ei->version('Path::Class') };
$version_ok = module_version_is('Path::Class', $version, '0.24');
$failed->{'Path::Class'} = {version => '0.24'} unless $require_ok && $version_ok;

# Test::MockModule
$require_ok = require_ok('Test::MockModule');
$version = '';
eval { $version = $ei->version('Test::MockModule') };
$version_ok = module_version_is('Test::MockModule', $version, '0.05');
$failed->{'Test::MockModule'} = {version => '0.05'} unless $require_ok && $version_ok;

# Test::Pod
$require_ok = require_ok('Test::Pod');
$version = '';
eval { $version = $ei->version('Test::Pod') };
$version_ok = module_version_is('Test::Pod', $version, '1.45');
$failed->{'Test::Pod'} = {version => '1.45'} unless $require_ok && $version_ok;

# URI
$require_ok = require_ok('URI');
$version = '';
eval { $version = $ei->version('URI') };
$version_ok = module_version_is('URI', $version, '1.59');
$failed->{'URI'} = {version => '1.59'} unless $require_ok && $version_ok;

# Validator::Custom
$require_ok = require_ok('Validator::Custom');
$version = '';
eval { $version = $ei->version('Validator::Custom') };
$version_ok = module_version_is('Validator::Custom', $version, '0.1426');
$failed->{'Validator::Custom'} = {version => '0.1426'} unless $require_ok && $version_ok;

# WWW::RobotRules
$require_ok = require_ok('WWW::RobotRules');
$version = '';
eval { $version = $ei->version('WWW::RobotRules') };
$version_ok = module_version_is('WWW::RobotRules', $version, '6.01');
$failed->{'WWW::RobotRules'} = {version => '6.01'} unless $require_ok && $version_ok;

# common::sense
$require_ok = require_ok('common::sense');
$version = '';
eval { $version = $ei->version('common::sense') };
$version_ok = module_version_is('common::sense', $version, '3.4');
$failed->{'common::sense'} = {version => '3.4'} unless $require_ok && $version_ok;

# Print module URLs
if (my @modules = sort keys %$failed) {
  print "# Lacking module URLs\n" unless defined $command;
  for my $module (@modules) {
    my $version = $failed->{$module}{version};
    my $url = Test::ModuleVersion::get_module_url($module, $version);
    if (defined $command && $command eq 'install_list') {
      print "$url\n" if defined $url
    }
    else {
      my $output = defined $url ? "# $url" : "# $module $version is unknown";
      print "$output\n";
    }
  }
}
