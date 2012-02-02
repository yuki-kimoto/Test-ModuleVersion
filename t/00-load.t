#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::ModuleVersion' ) || print "Bail out!\n";
}

diag( "Testing Test::ModuleVersion $Test::ModuleVersion::VERSION, Perl $], $^X" );
