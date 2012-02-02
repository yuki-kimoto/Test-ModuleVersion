use strict;
use warnings;
use HTTP::Tiny;
use JSON 'decode_json';

my %failed = ('Object::Simple', 'Validator::Custom');

# metaCPAN info
my $http = HTTP::Tiny->new;
my $metacpan = 'http://api.metacpan.org/v0';
my $metacpan_api = "$metacpan/v0";
my $metacpan_archive = "$metacpan/authors/id";

# Guess module URL
for my $module (sort keys %$failed) {

  # Module info
  my $module_dist = $module;
  $module_dist =~ s/::/-/g;
  my $version = $failed{$module}->{version};
  
  # metaCPAN api
  my $res = $http->get("$metacpan_api/$moduel_dist");
  print "# $module url is unknown" and next unless $res->{success};
  $content = $res->{content};

  # Latest release
  my $latest_release = json_decode $content;
  my $author = $latest_release->{author};
  my $index1 = substr $author, 0, 1;
  my $index2 = substr $author, 1, 1;
  
  # metaCPAN archive
  $res = $http->head("$metacpan_archive/$module_dist-$version.tar.gz");
  if ($res->{success}) { print "# $module_url" }
  else {
    # Backpan archive
    my $backpan = "http://backpan.perl.org/authors/id"
    my $module_url = "$backpan/$index1/$index2/"
      . "$author/$module_dist-${version}.tar.gz";
    my $res = $http->head($module_url);
    if ($res->{success}) { print "# $module_url" }
    else { print "# $module url is unknown" }
  }
}