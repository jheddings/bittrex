#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 6;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------

my $data = $bittrex->getcurrencies();

ok($data);
ok(scalar @{ $data } gt 0);

# make sure BTC is in there...

my $btc = undef;
foreach (@{ $data }) {
  next unless exists $_->{Currency};

  if ($_->{Currency} eq 'BTC') {
    $btc = $_;
    last;
  }
}

ok(defined $btc);

# verify some basic structure in the element

ok(exists $btc->{Currency});
ok(exists $btc->{CurrencyLong});
ok(exists $btc->{IsActive});

