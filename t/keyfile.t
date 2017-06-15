#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use FindBin;
use Bittrex;
use Test::Simple tests => 16;

use Bittrex::Keyfile;

# this is a little strange, since the test path will vary whether or not the
# use has a local keyfile...

my $keyfile = File::Spec->catfile($FindBin::Bin, 'apikey.cfg');
my ($key, $secret) = Bittrex::Keyfile::load($keyfile);

if (-f $keyfile) {
  ok(defined $key and defined $secret);
} else {
  ok(! defined $key and ! defined $secret);
}

($key, $secret) = Bittrex::Keyfile::load('/tmp/there/should/not/be/a/file/here');
ok(! defined $key and ! defined $secret);

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_basic.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok($key eq 'VALID_API_KEY');
ok($secret eq 'VALID_SECRET');

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_alt1.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok($key eq 'VALID_API_KEY');
ok($secret eq 'VALID_SECRET');

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_alt2.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok($key eq 'VALID_API_KEY');
ok($secret eq 'VALID_SECRET');

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_extra.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok($key eq 'VALID_API_KEY');
ok($secret eq 'VALID_SECRET');

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_missing.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok(! defined $key);
ok(! defined $secret);

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_invalid.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok(! defined $key);
ok(! defined $secret);

$keyfile = File::Spec->catfile($FindBin::Bin, 'keyfile_empty.cfg');
($key, $secret) = Bittrex::Keyfile::load($keyfile);
ok(! defined $key);
ok(! defined $secret);

