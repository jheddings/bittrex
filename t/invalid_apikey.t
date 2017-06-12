#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 9;

# simple tests to make sure bad keys work
my $bittrex_no_auth = Bittrex->new();
my $bittrex_bad_key = Bittrex->new('no_key', undef);
my $bittrex_bad_secret = Bittrex->new(undef, 'no_secret');
my $bittrex_bad_auth = Bittrex->new('no_key', 'no_secret');

#-------------------------------------------------------------------------------
## account calls

ok(! $bittrex_no_auth->getbalances());
ok(! $bittrex_no_auth->getbalance('LTC'));

ok(! $bittrex_bad_key->getbalances());
ok(! $bittrex_bad_key->getbalance('ETH'));

ok(! $bittrex_bad_secret->getbalances());
ok(! $bittrex_bad_secret->getbalance('DASH'));

ok(! $bittrex_bad_auth->getbalances());
ok(! $bittrex_bad_auth->getbalance('BTC'));
ok(! $bittrex_bad_auth->getbalance('*'));

