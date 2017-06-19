#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 7;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

my $hist = $bittrex->getmarkethistory('BTC-LTC');

ok(defined $hist);
ok(scalar @{ $hist } gt 0);

my $order = @{ $hist }[0];
ok(exists $order->{Id});

# some basic negative testing...

ok(! $bittrex->getmarkethistory());
ok(! $bittrex->getmarkethistory(''));
ok(! $bittrex->getmarkethistory('NADA-NONE'));
ok(! $bittrex->getmarkethistory('!'));

