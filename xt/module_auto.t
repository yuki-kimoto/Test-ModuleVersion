use Test::More tests => 72;
use strict;
use warnings;
use ExtUtils::Installed;
use FindBin;

sub main {
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
  $version_ok = is($DBIx::Custom::VERSION, '0.2109', 'DBIx::Custom version: 0.2109');
  push @$modules, ['DBIx::Custom' => '0.2109'];
  push @$failed, ['DBIx::Custom' => '0.2109'] unless $require_ok && $version_ok;

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
}

package Test::ModuleVersion;
our $VERSION = '0.05';

package
  Test::ModuleVersion::Object::Simple;

our $VERSION = '3.0626';

use strict;
use warnings;
no warnings 'redefine';

use Carp ();

sub import {
    my ($class, @methods) = @_;
    
    # Caller
    my $caller = caller;
    
    # Base
    if ((my $flag = $methods[0] || '') eq '-base') {

        # Can haz?
        no strict 'refs';
        no warnings 'redefine';
        *{"${caller}::has"} = sub { attr($caller, @_) };
        
        # Inheritance
        if (my $module = $methods[1]) {
            $module =~ s/::|'/\//g;
            require "$module.pm" unless $module->can('new');
            push @{"${caller}::ISA"}, $module;
        }
        else {
            push @{"${caller}::ISA"}, $class;
        }

        # strict!
        strict->import;
        warnings->import;

        # Modern!
        feature->import(':5.10') if $] >= 5.010;        
    }
    # Method export
    else {
        
        # Exports
        my %exports = map { $_ => 1 } qw/new attr class_attr dual_attr/;
        
        # Export methods
        foreach my $method (@methods) {
            
            # Can be Exported?
            Carp::croak("Cannot export '$method'.")
              unless $exports{$method};
            
            # Export
            no strict 'refs';
            *{"${caller}::$method"} = \&{"$method"};
        }
    }
}

sub new {
  my $class = shift;
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub attr {
    my ($self, @args) = @_;
    
    my $class = ref $self || $self;
    
    # Fix argument
    unshift @args, (shift @args, undef) if @args % 2;
    
    for (my $i = 0; $i < @args; $i += 2) {
        
        # Attribute name
        my $attrs = $args[$i];
        $attrs = [$attrs] unless ref $attrs eq 'ARRAY';
        
        # Default
        my $default = $args[$i + 1];
        
        foreach my $attr (@$attrs) {

            Carp::croak("Default value of attr must be string or number " . 
                        "or code reference (${class}::$attr)")
              unless !ref $default || ref $default eq 'CODE';

        # Code
        my $code;
        if (defined $default && ref $default) {



$code = sub {
    if(@_ == 1) {
        return $_[0]->{$attr} = $default->($_[0]) unless exists $_[0]->{$attr};
        return $_[0]->{$attr};
    }
    $_[0]->{$attr} = $_[1];
    $_[0];
}

        }
        elsif (defined $default && ! ref $default) {



$code = sub {
    if(@_ == 1) {
        return $_[0]->{$attr} = $default unless exists $_[0]->{$attr};
        return $_[0]->{$attr};
    }
    $_[0]->{$attr} = $_[1];
    $_[0];
}



    }
    else {



$code = sub {
    return $_[0]->{$attr} if @_ == 1;
    $_[0]->{$attr} = $_[1];
    $_[0];
}



    }
            
            no strict 'refs';
            *{"${class}::$attr"} = $code;
        }
    }
}

package
  Test::ModuleVersion::HTTP::Tiny;
use strict;
use warnings;
# ABSTRACT: A small, simple, correct HTTP/1.1 client
our $VERSION = '0.016'; # VERSION

use Carp ();


my @attributes;
BEGIN {
    @attributes = qw(agent default_headers max_redirect max_size proxy timeout);
    no strict 'refs';
    for my $accessor ( @attributes ) {
        *{$accessor} = sub {
            @_ > 1 ? $_[0]->{$accessor} = $_[1] : $_[0]->{$accessor};
        };
    }
}

sub new {
    my($class, %args) = @_;
    (my $agent = $class) =~ s{::}{-}g;
    my $self = {
        agent        => $agent . "/" . ($class->VERSION || 0),
        max_redirect => 5,
        timeout      => 60,
    };
    for my $key ( @attributes ) {
        $self->{$key} = $args{$key} if exists $args{$key}
    }

    # Never override proxy argument as this breaks backwards compat.
    if (!exists $self->{proxy} && (my $http_proxy = $ENV{http_proxy})) {
        if ($http_proxy =~ m{\Ahttp://[^/?#:@]+:\d+/?\z}) {
            $self->{proxy} = $http_proxy;
        }
        else {
            Carp::croak(qq{Environment 'http_proxy' must be in format http://<host>:<port>/\n});
        }
    }

    return bless $self, $class;
}


for my $sub_name ( qw/get head put post delete/ ) {
    my $req_method = uc $sub_name;
    no strict 'refs';
    eval <<"HERE";
    sub $sub_name {
        my (\$self, \$url, \$args) = \@_;
        \@_ == 2 || (\@_ == 3 && ref \$args eq 'HASH')
        or Carp::croak(q/Usage: \$http->$sub_name(URL, [HASHREF])/ . "\n");
        return \$self->request('$req_method', \$url, \$args || {});
    }
HERE
}


sub post_form {
    my ($self, $url, $data, $args) = @_;
    (@_ == 3 || @_ == 4 && ref $args eq 'HASH')
        or Carp::croak(q/Usage: $http->post_form(URL, DATAREF, [HASHREF])/ . "\n");

    my $headers = {};
    while ( my ($key, $value) = each %{$args->{headers} || {}} ) {
        $headers->{lc $key} = $value;
    }
    delete $args->{headers};

    return $self->request('POST', $url, {
            %$args,
            content => $self->www_form_urlencode($data),
            headers => {
                %$headers,
                'content-type' => 'application/x-www-form-urlencoded'
            },
        }
    );
}


sub mirror {
    my ($self, $url, $file, $args) = @_;
    @_ == 3 || (@_ == 4 && ref $args eq 'HASH')
      or Carp::croak(q/Usage: $http->mirror(URL, FILE, [HASHREF])/ . "\n");
    if ( -e $file and my $mtime = (stat($file))[9] ) {
        $args->{headers}{'if-modified-since'} ||= $self->_http_date($mtime);
    }
    my $tempfile = $file . int(rand(2**31));
    open my $fh, ">", $tempfile
        or Carp::croak(qq/Error: Could not open temporary file $tempfile for downloading: $!\n/);
    binmode $fh;
    $args->{data_callback} = sub { print {$fh} $_[0] };
    my $response = $self->request('GET', $url, $args);
    close $fh
        or Carp::croak(qq/Error: Could not close temporary file $tempfile: $!\n/);
    if ( $response->{success} ) {
        rename $tempfile, $file
            or Carp::croak(qq/Error replacing $file with $tempfile: $!\n/);
        my $lm = $response->{headers}{'last-modified'};
        if ( $lm and my $mtime = $self->_parse_http_date($lm) ) {
            utime $mtime, $mtime, $file;
        }
    }
    $response->{success} ||= $response->{status} eq '304';
    unlink $tempfile;
    return $response;
}


my %idempotent = map { $_ => 1 } qw/GET HEAD PUT DELETE OPTIONS TRACE/;

sub request {
    my ($self, $method, $url, $args) = @_;
    @_ == 3 || (@_ == 4 && ref $args eq 'HASH')
      or Carp::croak(q/Usage: $http->request(METHOD, URL, [HASHREF])/ . "\n");
    $args ||= {}; # we keep some state in this during _request

    # RFC 2616 Section 8.1.4 mandates a single retry on broken socket
    my $response;
    for ( 0 .. 1 ) {
        $response = eval { $self->_request($method, $url, $args) };
        last unless $@ && $idempotent{$method}
            && $@ =~ m{^(?:Socket closed|Unexpected end)};
    }

    if (my $e = "$@") {
        $response = {
            success => q{},
            status  => 599,
            reason  => 'Internal Exception',
            content => $e,
            headers => {
                'content-type'   => 'text/plain',
                'content-length' => length $e,
            }
        };
    }
    return $response;
}


sub www_form_urlencode {
    my ($self, $data) = @_;
    (@_ == 2 && ref $data)
        or Carp::croak(q/Usage: $http->www_form_urlencode(DATAREF)/ . "\n");
    (ref $data eq 'HASH' || ref $data eq 'ARRAY')
        or Carp::croak("form data must be a hash or array reference");

    my @params = ref $data eq 'HASH' ? %$data : @$data;
    @params % 2 == 0
        or Carp::croak("form data reference must have an even number of terms\n");

    my @terms;
    while( @params ) {
        my ($key, $value) = splice(@params, 0, 2);
        if ( ref $value eq 'ARRAY' ) {
            unshift @params, map { $key => $_ } @$value;
        }
        else {
            push @terms, join("=", map { $self->_uri_escape($_) } $key, $value);
        }
    }

    return join("&", sort @terms);
}

#--------------------------------------------------------------------------#
# private methods
#--------------------------------------------------------------------------#

my %DefaultPort = (
    http => 80,
    https => 443,
);

sub _request {
    my ($self, $method, $url, $args) = @_;

    my ($scheme, $host, $port, $path_query) = $self->_split_url($url);

    my $request = {
        method    => $method,
        scheme    => $scheme,
        host_port => ($port == $DefaultPort{$scheme} ? $host : "$host:$port"),
        uri       => $path_query,
        headers   => {},
    };

    my $handle  = Test::ModuleVersion::HTTP::Tiny::Handle->new(timeout => $self->{timeout});

    if ($self->{proxy}) {
        $request->{uri} = "$scheme://$request->{host_port}$path_query";
        die(qq/HTTPS via proxy is not supported\n/)
            if $request->{scheme} eq 'https';
        $handle->connect(($self->_split_url($self->{proxy}))[0..2]);
    }
    else {
        $handle->connect($scheme, $host, $port);
    }

    $self->_prepare_headers_and_cb($request, $args);
    $handle->write_request($request);

    my $response;
    do { $response = $handle->read_response_header }
        until (substr($response->{status},0,1) ne '1');

    if ( my @redir_args = $self->_maybe_redirect($request, $response, $args) ) {
        $handle->close;
        return $self->_request(@redir_args, $args);
    }

    if ($method eq 'HEAD' || $response->{status} =~ /^[23]04/) {
        # response has no message body
    }
    else {
        my $data_cb = $self->_prepare_data_cb($response, $args);
        $handle->read_body($data_cb, $response);
    }

    $handle->close;
    $response->{success} = substr($response->{status},0,1) eq '2';
    return $response;
}

sub _prepare_headers_and_cb {
    my ($self, $request, $args) = @_;

    for ($self->{default_headers}, $args->{headers}) {
        next unless defined;
        while (my ($k, $v) = each %$_) {
            $request->{headers}{lc $k} = $v;
        }
    }
    $request->{headers}{'host'}         = $request->{host_port};
    $request->{headers}{'connection'}   = "close";
    $request->{headers}{'user-agent'} ||= $self->{agent};

    if (defined $args->{content}) {
        $request->{headers}{'content-type'} ||= "application/octet-stream";
        if (ref $args->{content} eq 'CODE') {
            $request->{headers}{'transfer-encoding'} = 'chunked'
              unless $request->{headers}{'content-length'}
                  || $request->{headers}{'transfer-encoding'};
            $request->{cb} = $args->{content};
        }
        else {
            my $content = $args->{content};
            if ( $] ge '5.008' ) {
                utf8::downgrade($content, 1)
                    or die(qq/Wide character in request message body\n/);
            }
            $request->{headers}{'content-length'} = length $content
              unless $request->{headers}{'content-length'}
                  || $request->{headers}{'transfer-encoding'};
            $request->{cb} = sub { substr $content, 0, length $content, '' };
        }
        $request->{trailer_cb} = $args->{trailer_callback}
            if ref $args->{trailer_callback} eq 'CODE';
    }
    return;
}

sub _prepare_data_cb {
    my ($self, $response, $args) = @_;
    my $data_cb = $args->{data_callback};
    $response->{content} = '';

    if (!$data_cb || $response->{status} !~ /^2/) {
        if (defined $self->{max_size}) {
            $data_cb = sub {
                $_[1]->{content} .= $_[0];
                die(qq/Size of response body exceeds the maximum allowed of $self->{max_size}\n/)
                  if length $_[1]->{content} > $self->{max_size};
            };
        }
        else {
            $data_cb = sub { $_[1]->{content} .= $_[0] };
        }
    }
    return $data_cb;
}

sub _maybe_redirect {
    my ($self, $request, $response, $args) = @_;
    my $headers = $response->{headers};
    my ($status, $method) = ($response->{status}, $request->{method});
    if (($status eq '303' or ($status =~ /^30[127]/ && $method =~ /^GET|HEAD$/))
        and $headers->{location}
        and ++$args->{redirects} <= $self->{max_redirect}
    ) {
        my $location = ($headers->{location} =~ /^\//)
            ? "$request->{scheme}://$request->{host_port}$headers->{location}"
            : $headers->{location} ;
        return (($status eq '303' ? 'GET' : $method), $location);
    }
    return;
}

sub _split_url {
    my $url = pop;

    # URI regex adapted from the URI module
    my ($scheme, $authority, $path_query) = $url =~ m<\A([^:/?#]+)://([^/?#]*)([^#]*)>
      or die(qq/Cannot parse URL: '$url'\n/);

    $scheme     = lc $scheme;
    $path_query = "/$path_query" unless $path_query =~ m<\A/>;

    my $host = (length($authority)) ? lc $authority : 'localhost';
       $host =~ s/\A[^@]*@//;   # userinfo
    my $port = do {
       $host =~ s/:([0-9]*)\z// && length $1
         ? $1
         : ($scheme eq 'http' ? 80 : $scheme eq 'https' ? 443 : undef);
    };

    return ($scheme, $host, $port, $path_query);
}

# Date conversions adapted from HTTP::Date
my $DoW = "Sun|Mon|Tue|Wed|Thu|Fri|Sat";
my $MoY = "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec";
sub _http_date {
    my ($sec, $min, $hour, $mday, $mon, $year, $wday) = gmtime($_[1]);
    return sprintf("%s, %02d %s %04d %02d:%02d:%02d GMT",
        substr($DoW,$wday*4,3),
        $mday, substr($MoY,$mon*4,3), $year+1900,
        $hour, $min, $sec
    );
}

sub _parse_http_date {
    my ($self, $str) = @_;
    require Time::Local;
    my @tl_parts;
    if ($str =~ /^[SMTWF][a-z]+, +(\d{1,2}) ($MoY) +(\d\d\d\d) +(\d\d):(\d\d):(\d\d) +GMT$/) {
        @tl_parts = ($6, $5, $4, $1, (index($MoY,$2)/4), $3);
    }
    elsif ($str =~ /^[SMTWF][a-z]+, +(\d\d)-($MoY)-(\d{2,4}) +(\d\d):(\d\d):(\d\d) +GMT$/ ) {
        @tl_parts = ($6, $5, $4, $1, (index($MoY,$2)/4), $3);
    }
    elsif ($str =~ /^[SMTWF][a-z]+ +($MoY) +(\d{1,2}) +(\d\d):(\d\d):(\d\d) +(?:[^0-9]+ +)?(\d\d\d\d)$/ ) {
        @tl_parts = ($5, $4, $3, $2, (index($MoY,$1)/4), $6);
    }
    return eval {
        my $t = @tl_parts ? Time::Local::timegm(@tl_parts) : -1;
        $t < 0 ? undef : $t;
    };
}

# URI escaping adapted from URI::Escape
# c.f. http://www.w3.org/TR/html4/interact/forms.html#h-17.13.4.1
# perl 5.6 ready UTF-8 encoding adapted from JSON::PP
my %escapes = map { chr($_) => sprintf("%%%02X", $_) } 0..255;
$escapes{' '}="+";
my $unsafe_char = qr/[^A-Za-z0-9\-\._~]/;

sub _uri_escape {
    my ($self, $str) = @_;
    if ( $] ge '5.008' ) {
        utf8::encode($str);
    }
    else {
        $str = pack("U*", unpack("C*", $str)) # UTF-8 encode a byte string
            if ( length $str == do { use bytes; length $str } );
        $str = pack("C*", unpack("C*", $str)); # clear UTF-8 flag
    }
    $str =~ s/($unsafe_char)/$escapes{$1}/ge;
    return $str;
}

package
    Test::ModuleVersion::HTTP::Tiny::Handle; # hide from PAUSE/indexers
use strict;
use warnings;

use Errno      qw[EINTR EPIPE];
use IO::Socket qw[SOCK_STREAM];

sub BUFSIZE () { 32768 }

my $Printable = sub {
    local $_ = shift;
    s/\r/\\r/g;
    s/\n/\\n/g;
    s/\t/\\t/g;
    s/([^\x20-\x7E])/sprintf('\\x%.2X', ord($1))/ge;
    $_;
};

my $Token = qr/[\x21\x23-\x27\x2A\x2B\x2D\x2E\x30-\x39\x41-\x5A\x5E-\x7A\x7C\x7E]/;

sub new {
    my ($class, %args) = @_;
    return bless {
        rbuf             => '',
        timeout          => 60,
        max_line_size    => 16384,
        max_header_lines => 64,
        %args
    }, $class;
}

my $ssl_verify_args = {
    check_cn => "when_only",
    wildcards_in_alt => "anywhere",
    wildcards_in_cn => "anywhere"
};

sub connect {
    @_ == 4 || die(q/Usage: $handle->connect(scheme, host, port)/ . "\n");
    my ($self, $scheme, $host, $port) = @_;

    if ( $scheme eq 'https' ) {
        eval "require IO::Socket::SSL"
            unless exists $INC{'IO/Socket/SSL.pm'};
        die(qq/IO::Socket::SSL must be installed for https support\n/)
            unless $INC{'IO/Socket/SSL.pm'};
    }
    elsif ( $scheme ne 'http' ) {
      die(qq/Unsupported URL scheme '$scheme'\n/);
    }

    $self->{fh} = 'IO::Socket::INET'->new(
        PeerHost  => $host,
        PeerPort  => $port,
        Proto     => 'tcp',
        Type      => SOCK_STREAM,
        Timeout   => $self->{timeout}
    ) or die(qq/Could not connect to '$host:$port': $@\n/);

    binmode($self->{fh})
      or die(qq/Could not binmode() socket: '$!'\n/);

    if ( $scheme eq 'https') {
        IO::Socket::SSL->start_SSL($self->{fh});
        ref($self->{fh}) eq 'IO::Socket::SSL'
            or die(qq/SSL connection failed for $host\n/);
        $self->{fh}->verify_hostname( $host, $ssl_verify_args )
            or die(qq/SSL certificate not valid for $host\n/);
    }

    $self->{host} = $host;
    $self->{port} = $port;

    return $self;
}

sub close {
    @_ == 1 || die(q/Usage: $handle->close()/ . "\n");
    my ($self) = @_;
    CORE::close($self->{fh})
      or die(qq/Could not close socket: '$!'\n/);
}

sub write {
    @_ == 2 || die(q/Usage: $handle->write(buf)/ . "\n");
    my ($self, $buf) = @_;

    if ( $] ge '5.008' ) {
        utf8::downgrade($buf, 1)
            or die(qq/Wide character in write()\n/);
    }

    my $len = length $buf;
    my $off = 0;

    local $SIG{PIPE} = 'IGNORE';

    while () {
        $self->can_write
          or die(qq/Timed out while waiting for socket to become ready for writing\n/);
        my $r = syswrite($self->{fh}, $buf, $len, $off);
        if (defined $r) {
            $len -= $r;
            $off += $r;
            last unless $len > 0;
        }
        elsif ($! == EPIPE) {
            die(qq/Socket closed by remote server: $!\n/);
        }
        elsif ($! != EINTR) {
            die(qq/Could not write to socket: '$!'\n/);
        }
    }
    return $off;
}

sub read {
    @_ == 2 || @_ == 3 || die(q/Usage: $handle->read(len [, allow_partial])/ . "\n");
    my ($self, $len, $allow_partial) = @_;

    my $buf  = '';
    my $got = length $self->{rbuf};

    if ($got) {
        my $take = ($got < $len) ? $got : $len;
        $buf  = substr($self->{rbuf}, 0, $take, '');
        $len -= $take;
    }

    while ($len > 0) {
        $self->can_read
          or die(q/Timed out while waiting for socket to become ready for reading/ . "\n");
        my $r = sysread($self->{fh}, $buf, $len, length $buf);
        if (defined $r) {
            last unless $r;
            $len -= $r;
        }
        elsif ($! != EINTR) {
            die(qq/Could not read from socket: '$!'\n/);
        }
    }
    if ($len && !$allow_partial) {
        die(qq/Unexpected end of stream\n/);
    }
    return $buf;
}

sub readline {
    @_ == 1 || die(q/Usage: $handle->readline()/ . "\n");
    my ($self) = @_;

    while () {
        if ($self->{rbuf} =~ s/\A ([^\x0D\x0A]* \x0D?\x0A)//x) {
            return $1;
        }
        if (length $self->{rbuf} >= $self->{max_line_size}) {
            die(qq/Line size exceeds the maximum allowed size of $self->{max_line_size}\n/);
        }
        $self->can_read
          or die(qq/Timed out while waiting for socket to become ready for reading\n/);
        my $r = sysread($self->{fh}, $self->{rbuf}, BUFSIZE, length $self->{rbuf});
        if (defined $r) {
            last unless $r;
        }
        elsif ($! != EINTR) {
            die(qq/Could not read from socket: '$!'\n/);
        }
    }
    die(qq/Unexpected end of stream while looking for line\n/);
}

sub read_header_lines {
    @_ == 1 || @_ == 2 || die(q/Usage: $handle->read_header_lines([headers])/ . "\n");
    my ($self, $headers) = @_;
    $headers ||= {};
    my $lines   = 0;
    my $val;

    while () {
         my $line = $self->readline;

         if (++$lines >= $self->{max_header_lines}) {
             die(qq/Header lines exceeds maximum number allowed of $self->{max_header_lines}\n/);
         }
         elsif ($line =~ /\A ([^\x00-\x1F\x7F:]+) : [\x09\x20]* ([^\x0D\x0A]*)/x) {
             my ($field_name) = lc $1;
             if (exists $headers->{$field_name}) {
                 for ($headers->{$field_name}) {
                     $_ = [$_] unless ref $_ eq "ARRAY";
                     push @$_, $2;
                     $val = \$_->[-1];
                 }
             }
             else {
                 $val = \($headers->{$field_name} = $2);
             }
         }
         elsif ($line =~ /\A [\x09\x20]+ ([^\x0D\x0A]*)/x) {
             $val
               or die(qq/Unexpected header continuation line\n/);
             next unless length $1;
             $$val .= ' ' if length $$val;
             $$val .= $1;
         }
         elsif ($line =~ /\A \x0D?\x0A \z/x) {
            last;
         }
         else {
            die(q/Malformed header line: / . $Printable->($line) . "\n");
         }
    }
    return $headers;
}

sub write_request {
    @_ == 2 || die(q/Usage: $handle->write_request(request)/ . "\n");
    my($self, $request) = @_;
    $self->write_request_header(@{$request}{qw/method uri headers/});
    $self->write_body($request) if $request->{cb};
    return;
}

my %HeaderCase = (
    'content-md5'      => 'Content-MD5',
    'etag'             => 'ETag',
    'te'               => 'TE',
    'www-authenticate' => 'WWW-Authenticate',
    'x-xss-protection' => 'X-XSS-Protection',
);

sub write_header_lines {
    (@_ == 2 && ref $_[1] eq 'HASH') || die(q/Usage: $handle->write_header_lines(headers)/ . "\n");
    my($self, $headers) = @_;

    my $buf = '';
    while (my ($k, $v) = each %$headers) {
        my $field_name = lc $k;
        if (exists $HeaderCase{$field_name}) {
            $field_name = $HeaderCase{$field_name};
        }
        else {
            $field_name =~ /\A $Token+ \z/xo
              or die(q/Invalid HTTP header field name: / . $Printable->($field_name) . "\n");
            $field_name =~ s/\b(\w)/\u$1/g;
            $HeaderCase{lc $field_name} = $field_name;
        }
        for (ref $v eq 'ARRAY' ? @$v : $v) {
            /[^\x0D\x0A]/
              or die(qq/Invalid HTTP header field value ($field_name): / . $Printable->($_). "\n");
            $buf .= "$field_name: $_\x0D\x0A";
        }
    }
    $buf .= "\x0D\x0A";
    return $self->write($buf);
}

sub read_body {
    @_ == 3 || die(q/Usage: $handle->read_body(callback, response)/ . "\n");
    my ($self, $cb, $response) = @_;
    my $te = $response->{headers}{'transfer-encoding'} || '';
    if ( grep { /chunked/i } ( ref $te eq 'ARRAY' ? @$te : $te ) ) {
        $self->read_chunked_body($cb, $response);
    }
    else {
        $self->read_content_body($cb, $response);
    }
    return;
}

sub write_body {
    @_ == 2 || die(q/Usage: $handle->write_body(request)/ . "\n");
    my ($self, $request) = @_;
    if ($request->{headers}{'content-length'}) {
        return $self->write_content_body($request);
    }
    else {
        return $self->write_chunked_body($request);
    }
}

sub read_content_body {
    @_ == 3 || @_ == 4 || die(q/Usage: $handle->read_content_body(callback, response, [read_length])/ . "\n");
    my ($self, $cb, $response, $content_length) = @_;
    $content_length ||= $response->{headers}{'content-length'};

    if ( $content_length ) {
        my $len = $content_length;
        while ($len > 0) {
            my $read = ($len > BUFSIZE) ? BUFSIZE : $len;
            $cb->($self->read($read, 0), $response);
            $len -= $read;
        }
    }
    else {
        my $chunk;
        $cb->($chunk, $response) while length( $chunk = $self->read(BUFSIZE, 1) );
    }

    return;
}

sub write_content_body {
    @_ == 2 || die(q/Usage: $handle->write_content_body(request)/ . "\n");
    my ($self, $request) = @_;

    my ($len, $content_length) = (0, $request->{headers}{'content-length'});
    while () {
        my $data = $request->{cb}->();

        defined $data && length $data
          or last;

        if ( $] ge '5.008' ) {
            utf8::downgrade($data, 1)
                or die(qq/Wide character in write_content()\n/);
        }

        $len += $self->write($data);
    }

    $len == $content_length
      or die(qq/Content-Length missmatch (got: $len expected: $content_length)\n/);

    return $len;
}

sub read_chunked_body {
    @_ == 3 || die(q/Usage: $handle->read_chunked_body(callback, $response)/ . "\n");
    my ($self, $cb, $response) = @_;

    while () {
        my $head = $self->readline;

        $head =~ /\A ([A-Fa-f0-9]+)/x
          or die(q/Malformed chunk head: / . $Printable->($head) . "\n");

        my $len = hex($1)
          or last;

        $self->read_content_body($cb, $response, $len);

        $self->read(2) eq "\x0D\x0A"
          or die(qq/Malformed chunk: missing CRLF after chunk data\n/);
    }
    $self->read_header_lines($response->{headers});
    return;
}

sub write_chunked_body {
    @_ == 2 || die(q/Usage: $handle->write_chunked_body(request)/ . "\n");
    my ($self, $request) = @_;

    my $len = 0;
    while () {
        my $data = $request->{cb}->();

        defined $data && length $data
          or last;

        if ( $] ge '5.008' ) {
            utf8::downgrade($data, 1)
                or die(qq/Wide character in write_chunked_body()\n/);
        }

        $len += length $data;

        my $chunk  = sprintf '%X', length $data;
           $chunk .= "\x0D\x0A";
           $chunk .= $data;
           $chunk .= "\x0D\x0A";

        $self->write($chunk);
    }
    $self->write("0\x0D\x0A");
    $self->write_header_lines($request->{trailer_cb}->())
        if ref $request->{trailer_cb} eq 'CODE';
    return $len;
}

sub read_response_header {
    @_ == 1 || die(q/Usage: $handle->read_response_header()/ . "\n");
    my ($self) = @_;

    my $line = $self->readline;

    $line =~ /\A (HTTP\/(0*\d+\.0*\d+)) [\x09\x20]+ ([0-9]{3}) [\x09\x20]+ ([^\x0D\x0A]*) \x0D?\x0A/x
      or die(q/Malformed Status-Line: / . $Printable->($line). "\n");

    my ($protocol, $version, $status, $reason) = ($1, $2, $3, $4);

    die (qq/Unsupported HTTP protocol: $protocol\n/)
        unless $version =~ /0*1\.0*[01]/;

    return {
        status   => $status,
        reason   => $reason,
        headers  => $self->read_header_lines,
        protocol => $protocol,
    };
}

sub write_request_header {
    @_ == 4 || die(q/Usage: $handle->write_request_header(method, request_uri, headers)/ . "\n");
    my ($self, $method, $request_uri, $headers) = @_;

    return $self->write("$method $request_uri HTTP/1.1\x0D\x0A")
         + $self->write_header_lines($headers);
}

sub _do_timeout {
    my ($self, $type, $timeout) = @_;
    $timeout = $self->{timeout}
        unless defined $timeout && $timeout >= 0;

    my $fd = fileno $self->{fh};
    defined $fd && $fd >= 0
      or die(qq/select(2): 'Bad file descriptor'\n/);

    my $initial = time;
    my $pending = $timeout;
    my $nfound;

    vec(my $fdset = '', $fd, 1) = 1;

    while () {
        $nfound = ($type eq 'read')
            ? select($fdset, undef, undef, $pending)
            : select(undef, $fdset, undef, $pending) ;
        if ($nfound == -1) {
            $! == EINTR
              or die(qq/select(2): '$!'\n/);
            redo if !$timeout || ($pending = $timeout - (time - $initial)) > 0;
            $nfound = 0;
        }
        last;
    }
    $! = 0;
    return $nfound;
}

sub can_read {
    @_ == 1 || @_ == 2 || die(q/Usage: $handle->can_read([timeout])/ . "\n");
    my $self = shift;
    return $self->_do_timeout('read', @_)
}

sub can_write {
    @_ == 1 || @_ == 2 || die(q/Usage: $handle->can_write([timeout])/ . "\n");
    my $self = shift;
    return $self->_do_timeout('write', @_)
}

package Test::ModuleVersion;
our @ISA = ('Test::ModuleVersion::Object::Simple');
use strict;
use warnings;
use ExtUtils::Installed;
use Carp 'croak';
use JSON 'decode_json';

sub has { __PACKAGE__->Test::ModuleVersion::Object::Simple::attr(@_) }
has default_ignore => sub { ['Perl', 'Test::ModuleVersion'] };
has ignore => sub { [] };
has lib => sub { [] };
has modules => sub { [] };

sub detect {
  my $self = shift;
  
  # Detect installed modules
  my $ei = ExtUtils::Installed->new;
  my $modules = [];
  push @$modules, [$_ => $ei->version($_)] for sort $ei->modules;
  $self->modules($modules);
  
  return $self;
}

sub get_module_url {
  my ($module, $version) = @_;
  
  # Module
  my $module_dist = $module;
  $module_dist =~ s/::/-/g;
  
  # Get dounload URL using metaCPAN api
  my $metacpan_api = 'http://api.metacpan.org/v0';
  my $search = "release/_search?q=name:$module_dist-$version"
    . "&fields=download_url,name";
  my $http = Test::ModuleVersion::HTTP::Tiny->new;
  my $res = $http->get("$metacpan_api/$search");
  if ($res->{success}) {
    my $release = decode_json $res->{content};
    return $release->{hits}{hits}[0]{fields}{download_url};
  }
  
  return;
}

sub test_script {
  my $self = shift;
  
  # Test code
  my $code = <<'EOS';
use strict;
use warnings;
use ExtUtils::Installed;
use FindBin;

EOS
  
  # Library path
  $code .= qq|use lib "\$FindBin::Bin/$_";\n| for @{$self->lib};
  
  # Main
  $code .= <<'EOS';
sub main {
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

  my $modules = [];
  my $failed = [];
  my $require_ok;
  my $version_ok;
  my $version;

EOS
  
  # Module and version check
  my $test_count = 0;
  for my $m (@{$self->modules}) {
    my ($module, $version) = @$m;
    next if grep { $module eq $_ } @{$self->default_ignore};
    next if grep { $module eq $_ } @{$self->ignore};
    $code .= "  # $module\n"
      . "  \$require_ok = require_ok('$module');\n"
      . "  \$version_ok = is(\$${module}::VERSION, '$version', '$module version: $version');\n"
      . "  push \@\$modules, ['$module' => '$version'];\n"
      . "  push \@\$failed, ['$module' => '$version'] unless \$require_ok && \$version_ok;\n\n";
    $test_count += 2;
  }
  
  # Print module URLs
  $code .= <<'EOS';
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
}

EOS
  
  # Embbed Test::ModuleVersion
  $code .= $self->_source . "\n";
  
  # Run
  $code .= "package main;\n"
    . "main(\@ARGV);\n";
  
  # Test count
  $code = "use Test::More tests => $test_count;\n" . $code;
  
  return $code;
}

sub _source {
  my $self = shift;
  
  # Source
  my $class = __PACKAGE__;
  $class =~ s/::/\//g;
  $class .= '.pm';
  my $path = $INC{$class};
  open my $fh, '<', $path
    or croak qq/Can't open "$path": $!/;
  my $source;
  while (my $line = <$fh>) {
    last if $line =~ /^=head1/;
    $source .= $line;
  }
  return $source;
}

1;


package main;
main(@ARGV);
