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

  $output = `perl $file list --fail`;
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

{
  # distnames
  my $tm = Test::ModuleVersion->new;
  $tm->lib('extlib/lib/perl5');
  $tm->distnames({
    'LWP' => 'libwww-perl',
    'IO::Compress::Base' => 'IO-Compress',
    'Cwd' => 'PathTools',
    'File::Spec' => 'PathTools',
    'List::Util' => 'Scalar-List-Utils',
    'Scalar::Util' => 'Scalar-List-Utils'
  });
  $tm->modules([
    ['LWP' => '6.03'],
    ['IO::Compress::Base' => '2.048'],
    ['Cwd' => '3.33'],
    ['File::Spec' => '3.33'],
    ['List::Util' => '1.23'],
    ['Scalar::Util' => '1.23'],
  ]);
  my $file = "$FindBin::Bin/output/module.t.output";
  open my $fh, '>', $file
    or die qr/Can't open file "$file": $!/;
  
  my $output;
  
  $| = 1;
  print $fh $tm->test_script;
  $output = `perl $file list`;
  like($output, qr/libwww-perl-6.03/);
  like($output, qr/IO-Compress-2.048/);
  like($output, qr/PathTools-3.33.*PathTools-3.33/ms);
  like($output, qr/Scalar-List-Utils-1.23.*Scalar-List-Utils-1.23/ms);
}
