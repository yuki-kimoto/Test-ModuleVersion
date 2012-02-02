use Test::More 'no_plan';
use strict;
use warnings;
use ExtUtils::Installed;

my $ei = ExtUtils::Installed->new;

sub module_version_is {
  my ($module, $got, $expected) = @_;
  
  is($got, $expected, "$module version: $got");
}

use_ok('AnyEvent');
module_version_is('AnyEvent', $ei->version('AnyEvent'), '6.13');

use_ok('DBD::Oracle');
module_version_is('DBD::Oracle', $ei->version('DBD::Oracle'), '1.38');

use_ok('DBD::Pg');
module_version_is('DBD::Pg', $ei->version('DBD::Pg'), '2.18.1');

use_ok('DBD::SQLite');
module_version_is('DBD::SQLite', $ei->version('DBD::SQLite'), '1.35');

use_ok('DBD::mysql');
module_version_is('DBD::mysql', $ei->version('DBD::mysql'), '4.020');

use_ok('DBI');
module_version_is('DBI', $ei->version('DBI'), '1.616');

use_ok('DBIx::Connector');
module_version_is('DBIx::Connector', $ei->version('DBIx::Connector'), '0.47');

use_ok('DBIx::Custom');
module_version_is('DBIx::Custom', $ei->version('DBIx::Custom'), '0.2108');

use_ok('EV');
module_version_is('EV', $ei->version('EV'), '4.10');

use_ok('Email::Valid');
module_version_is('Email::Valid', $ei->version('Email::Valid'), '0.185');

use_ok('Email::Valid::Loose');
module_version_is('Email::Valid::Loose', $ei->version('Email::Valid::Loose'), '0.05');

use_ok('Module::Starter');
module_version_is('Module::Starter', $ei->version('Module::Starter'), '1.58');

use_ok('Mojolicious');
module_version_is('Mojolicious', $ei->version('Mojolicious'), '2.46');

use_ok('Object::Simple');
module_version_is('Object::Simple', $ei->version('Object::Simple'), '3.0625');

use_ok('Path::Class');
module_version_is('Path::Class', $ei->version('Path::Class'), '0.24');

use_ok('Test::MockModule');
module_version_is('Test::MockModule', $ei->version('Test::MockModule'), '0.05');

use_ok('Test::ModuleVersion');
module_version_is('Test::ModuleVersion', $ei->version('Test::ModuleVersion'), '0.01');

use_ok('Test::Pod');
module_version_is('Test::Pod', $ei->version('Test::Pod'), '1.45');

use_ok('Validator::Custom');
module_version_is('Validator::Custom', $ei->version('Validator::Custom'), '0.1426');

use_ok('common::sense');
module_version_is('common::sense', $ei->version('common::sense'), '3.4');

