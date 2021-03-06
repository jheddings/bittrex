# NAME

Bittrex - modules and utilities for interacting with the
[Bittrex](https://www.bittrex.com) exchange.

# SYNOPSIS

This project consists of the `Bittrex::API` module:

    use Bittrex::API;

    my $bittrex = Bittrex::API->new();
    my $market_data = $bittrex->getmarkets();

There is also a utility for interacting with the exchange from the command line:

    bittrex.pl --keyfile=apikey.cfg --getbalances

# DESCRIPTION

Bittrex is a leading cryptocurrency exchange for buying & selling digital
currency. This software assumes no risk and makes no guarantees of performance
on any trades. Any examples provided here are for reference only and do not
imply any recommendations for investment strategies.

Full API documentation can be found here:
[https://bittrex.com/Home/Api](https://bittrex.com/Home/Api).

# REQUIREMENTS

- **URI::Query** - to build proper query strings for requests
- **Config::Simple** - used to read configuration files

# INSTALLATION

To install using the default options and location, use the following commands:

    perl Makefile.PL
    make
    make install

Parameters may be optionally passed to `Makefile.PL` to alter the
behavior. See [ExtUtils::MakeMaker](http://perldoc.perl.org/ExtUtils/MakeMaker.html)
for a full list of supported attributes.  The most common parameter to set is
`INSTALL_BASE` which sets the top of the installation target.

For example, to change the base installation path, use the following:

    perl Makefile.PL INSTALL_BASE=/usr/local

Tests are included with the module, however they require a valid API key in order to
succeed.  Eventually, I hope to mock out the API so they can run without direct access
to the API service.  If that happens, or you just want to try it out, use the following:

    make test

# AUTHOR

Developed and maintained by [jheddings](https://github.com/jheddings).

Tips are always appreciated!

- BTC - `1K6mkumfqTQTF4HJuLZAh1g8uRHQhWLomz`
- ETH - `0xA114CE80Fc995a993d5726a74DAf08ad8C739Af4`
- DASH - `XmTsc9qQQctrauq8zVXXoL9c8DKd29q2Gd`
- LTC - `LLscXRCUndQRjQdbTouvDE9NH5fiaanZzo`

# COPYRIGHT

Copyright (c) 2017 Jason Heddings

Licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT),
which is also included in the original [source code](https://github.com/jheddings/bittrex)
of this project.

# SEE ALSO

[Bittrex::API](https://metacpan.org/pod/Bittrex::API)
