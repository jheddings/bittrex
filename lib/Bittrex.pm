package Bittrex;

use strict;
use warnings;

use JSON;
use LWP::UserAgent;
use HTML::Entities;
use Data::Dumper;

use constant {
  APIROOT => 'https://bittrex.com/api/v1.1'
};

# XXX it would be better to store this in the object reference...
my $client = LWP::UserAgent->new();

################################################################################
sub ltrim { $_ = shift; s/^\s+//; $_ }
sub rtrim { $_ = shift; s/\s+$//; $_ }
sub  trim { ltrim(rtrim(shift)) }

################################################################################
sub new {
  my $class = shift;

  my $self = {
  };

  bless $self, $class;
}

################################################################################
sub _get {
  my $self = shift;
  my $path = shift;

  # TODO support parameters
  my $resp = $client->get(APIROOT . $path);

  unless ($resp->is_success) {
    die $resp->status_line;
  }

  # XXX can we check the success flag here?

  # TODO improve error handling
  decode_json $resp->decoded_content;
}

################################################################################
# /public/getmarkets
sub getmarkets {
  my $self = shift;
  my $json = $self->_get('/public/getmarkets');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getcurrencies {
  my $self = shift;
  my $json = $self->_get('/public/getcurrencies');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getmarketsummaries {
  my $self = shift;
  my $json = $self->_get('/public/getmarketsummaries');
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getticker {
  my $self = shift;

  my ($market) = @_;
  $market = encode_entities($market);

  my $json = $self->_get("/public/getticker?market=$market");
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getmarketsummary {
  my $self = shift;

  my ($market) = @_;
  $market = encode_entities($market);

  my $json = $self->_get("/public/getmarketsummary?market=$market");
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getorderbook {
  my $self = shift;

  my ($market, $type, $depth) = @_;
  $market = encode_entities($market);
  $type = encode_entities($type);

  my $json = $self->_get("/public/getorderbook?market=$market&type=$type");
  $json->{success} ? $json->{result} : undef;
}

################################################################################
sub getmarkethistory {
  my $self = shift;

  my ($market) = @_;
  $market = encode_entities($market);

  my $json = $self->_get("/public/getmarkethistory?market=$market");
  $json->{success} ? $json->{result} : undef;
}

1;  ## EOM
