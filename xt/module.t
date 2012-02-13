use Test::More 'no_plan';
use strict;
use warnings;
use Test::ModuleVersion;
use FindBin;

{
  # Basci test
  my $tm = Test::ModuleVersion->new;
  $tm->comment(<<'EOS');
You can this test script by the following command

  perl mvt.pl > t/module.t
EOS
  $tm->lib(['extlib/lib/perl5']);
  $tm->modules([
    ['Object::Simple' => '3.0625'],
    ['Validator::Custom' => '0.1401'],
    ['___NotExitst' => '0.1'],
  ]);
  my $file = "$FindBin::Bin/output/module.t.output";
  open my $fh, '>', $file
    or die qr/Can't open file "$file": $!/;
  like($tm->test_script, qr#\Qperl mvt.pl > t/module.t#);
  
  my $output;
  
  $| = 1;
  print $fh $tm->test_script;
  $output = `perl $file`;
  like($output, qr/1\.\.6/);
  like($output, qr/ok 1/);
  like($output, qr/ok 2/);
  like($output, qr/ok 3/);
  like($output, qr/not ok 4/);
  like($output, qr/not ok 5/);
  like($output, qr/not ok 6/);

  $output = `perl $file list`;
  like($output, qr/http/);
  like($output, qr/Object-Simple-3.0625/);
  like($output, qr/Validator-Custom-0.1401/);
  unlike($output, qr/___NotExitst/);
  unlike($output, qr/\d\.\.\d/);

  $output = `perl $file list_fail`;
  like($output, qr/http/);
  unlike($output, qr/Object-Simple/);
  like($output, qr/Validator-Custom-0.1401/);
  unlike($output, qr/___NotExitst/);
}

{
  # string lib
  my $tm = Test::ModuleVersion->new;
  $tm->lib('extlib/lib/perl5');
  $tm->modules([
    ['Object::Simple' => '3.0625'],
    ['Validator::Custom' => '0.1401'],
    ['___NotExitst' => '0.1'],
  ]);
  my $file = "$FindBin::Bin/output/module.t.output";
  open my $fh, '>', $file
    or die qr/Can't open file "$file": $!/;
  
  my $output;
  
  $| = 1;
  print $fh $tm->test_script;
  $output = `perl $file`;
  like($output, qr/1\.\.6/);
  like($output, qr/ok 1/);
  like($output, qr/ok 2/);
  like($output, qr/ok 3/);
  like($output, qr/not ok 4/);
  like($output, qr/not ok 5/);
  like($output, qr/not ok 6/);
}