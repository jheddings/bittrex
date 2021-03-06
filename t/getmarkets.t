#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 5;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

my @data = $bittrex->getmarkets();

ok(@data);
ok(scalar @data gt 0);

my $market = $data[0];
ok(exists $market->{BaseCurrency});
ok(exists $market->{MarketCurrency});
ok(exists $market->{MarketName});

