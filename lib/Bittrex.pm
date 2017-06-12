package Bittrex;

=encoding utf8

=head1 NAME

Bittrex - API wrapper for the L<Bittrex|https://www.bittrex.com> trading platform.

=cut

use strict;
use warnings;

use JSON;
use LWP::UserAgent;
use URI::Query;
use Digest::SHA;
use Data::Dumper;

# TODO add logging

our $VERSION = '0.1.0';

use constant {
  APIROOT => 'https://bittrex.com/api/v1.1'
};

=head1 SYNOPSIS

  use Bittrex;

  my $bittrex = Bittrex->new();
  my $market_data = $bittrex->getmarkets();

  my $account = Bittrex->new($apikey, $apisecret);
  my $balances = $bittrex->getbalances();

=head1 DESCRIPTION

This is a basic wrapper for the Bittrex API. It will handle API signing using
your specific API keys. All information is exchanged directly with the Bittrex
API service using a secure HTTPS connections.

Unless otherwise specifically stated, each method returns the decoded JSON
object in the C<result> field of the response. If a call fails, the method
returns C<undef>.

Bittrex is a leading cryptocurrency exchange for buying & selling digital
currency. This software assumes no risk and makes no guarantees of performance
on any trades. Any examples provided here are for reference only and do not
imply any recommendations for investment strategies.

Full API documentation can be found here: L<https://bittrex.com/Home/Api>.

=head2 Methods

=over 4

=cut

################################################################################
=item B<new($my_key, $my_secret)>

The key and secret must be registered to your account under API keys. Be sure
to set appropriate permissions based on the actions you intend to perform.
Public actions do not require these values.

=cut

#---------------------------------------
sub new {
  my $class = shift;
  my ($key, $secret) = @_;

  my $ua = LWP::UserAgent->new();

  my $self = {
    key => $key,
    secret => $secret,
    client => $ua
  };

  bless $self, $class;
}

################################################################################
sub _get {
  my $self = shift;
  my ($path, $params) = @_;

  if (defined $self->{key} and defined $self->{secret}) {
    # TODO generate nonce
    # TODO add apikey to params
    # TODO generate hmac
  }

  # build the URL string
  my $qq = URI::Query->new($params);
  my $uri = APIROOT . "$path?$qq";

  printf("GET: %s\n", $uri);

  my $client = $self->{client};
  my $resp = $client->get($uri);

  unless ($resp->is_success) {
    die $resp->status_line;
  }

  # TODO improve error handling
  decode_json $resp->decoded_content;
}

################################################################################
sub _apisign {
  my $self = shift;
  my ($uri) = @_;
}

################################################################################
=item B<getmarkets()>

Used to get the open and available trading markets at Bittrex along with other metadata.

=cut

#---------------------------------------
sub getmarkets {
  my $self = shift;
  my $json = $self->_get('/public/getmarkets');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getcurrencies()>

Used to get all supported currencies at Bittrex along with other metadata.

=cut

#---------------------------------------
sub getcurrencies {
  my $self = shift;
  my $json = $self->_get('/public/getcurrencies');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getmarketsummaries()>

Used to get the last 24 hour summary of all active exchanges.

=cut

#---------------------------------------
sub getmarketsummaries {
  my $self = shift;
  my $json = $self->_get('/public/getmarketsummaries');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getticker($market)>

Used to get the current tick values for a market.

C<market> : (required) a string literal for the market (ex: BTC-LTC)

=cut

#---------------------------------------
sub getticker {
  my $self = shift;
  my ($market) = @_;

  my $json = $self->_get('/public/getticker', {
    market => $market
  });

  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getmarketsummary($market)>

Used to get the last 24 hour summary of a specified exchange.

C<market> : (required) a string literal for the market (ex: BTC-LTC)

=cut

#---------------------------------------
sub getmarketsummary {
  my $self = shift;
  my ($market) = @_;

  my $json = $self->_get('/public/getmarketsummary', {
    market => $market
  });

  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getorderbook()>

Used to get retrieve the orderbook for a given market

C<market> : (required) a string literal for the market (ex: BTC-LTC)
C<type> : (optional) buy, sell or both to identify the type of order book (default: both)
C<depth> : (optional) how deep of an order book to retrieve (default: 20, max: 50)

=cut

#---------------------------------------
sub getorderbook {
  my $self = shift;
  my ($market, $type, $depth) = @_;

  my $json = $self->_get('/public/getorderbook', {
    market => $market,
    type => $type
  });

  $json->{success} ? $json->{result} : undef;
}

################################################################################
=item B<getmarkethistory()>

Used to retrieve the latest trades that have occured for a specific market.

C<market> : (required) a string literal for the market (ex: BTC-LTC)

=cut

#---------------------------------------
sub getmarkethistory {
  my $self = shift;
  my ($market) = @_;

  my $json = $self->_get('/public/getmarkethistory', {
    market => $market
  });

  $json->{success} ? $json->{result} : undef;
}

1;  ## EOM
################################################################################

=back

=head1 COPYRIGHT

Copyright (c) 2017 Jason Heddings

Licensed under the terms of the L<MIT License|https://opensource.org/licenses/MIT>,
which is also included in the original source code of this project.

=cut
