# NAME

Bittrex - API wrapper for the [Bittrex](https://www.bittrex.com) exchange.

# SYNOPSIS

    use Bittrex;

    my $bittrex = Bittrex->new();
    my $market_data = $bittrex->getmarkets();

    my $account = Bittrex->new($apikey, $apisecret);
    my $balances = $bittrex->getbalances();

# DESCRIPTION

This is a basic wrapper for the Bittrex API. It will handle API signing using
your specific API keys. All information is exchanged directly with the Bittrex
API service using a secure HTTPS connections.

Unless otherwise specifically stated, each method returns the decoded JSON
object in the `result` field of the response. If a call fails, the method
returns `undef`.

Bittrex is a leading cryptocurrency exchange for buying & selling digital
currency. This software assumes no risk and makes no guarantees of performance
on any trades. Any examples provided here are for reference only and do not
imply any recommendations for investment strategies.

Full API documentation can be found here: [https://bittrex.com/Home/Api](https://bittrex.com/Home/Api).

This module is current as of API version 1.1.

## Methods

- **new($my\_key, $my\_secret)**

    The key and secret must be registered to your account under API keys. Be sure
    to set appropriate permissions based on the actions you intend to perform.
    Public actions do not require these values.

- **getmarkets()**

    Used to get the open and available trading markets at Bittrex along with other metadata.

- **getcurrencies()**

    Used to get all supported currencies at Bittrex along with other metadata.

- **getmarketsummaries()**

    Used to get the last 24 hour summary of all active exchanges.

- **getticker($market)**

    Used to get the current tick values for a market.

    `market` : (required) a string literal for the market (ex: BTC-LTC)

- **getmarketsummary($market)**

    Used to get the last 24 hour summary of a specified exchange.

    `market` : (required) a string literal for the market (ex: BTC-LTC)

- **getorderbook($market, $type, $depth)**

    Used to get retrieve the orderbook for a given market

    `market` : (required) a string literal for the market (ex: BTC-LTC)
    `type` : (optional) buy, sell or both to identify the type of order book (default: both)
    `depth` : (optional) how deep of an order book to retrieve (default: 20, max: 50)

- **getmarkethistory($market)**

    Used to retrieve the latest trades that have occured for a specific market.

    `market` : (required) a string literal for the market (ex: BTC-LTC)

- **buylimit($market, $quantity, $rate)**

    Used to place a buy-limit order in a specific market. Make sure you have the
    proper permissions set on your API keys for this call to work.

    On success, returns the UUID of the order.

    `market` (required) a string literal for the market (ex: BTC-LTC)
    `quantity` (required) the amount to purchase
    `rate` (required) the rate at which to place the order.

- **selllimit($market, $quantity, $rate)**

    Used to place a sell-limit order in a specific market. Make sure you have the
    proper permissions set on your API keys for this call to work.

    On success, returns the UUID of the order.

    `market` (required) a string literal for the market (ex: BTC-LTC)
    `quantity` (required) the amount to purchase
    `rate` (required) the rate at which to place the order.

- **cancel($uuid)**

    Used to cancel a buy or sell order.

    `uuid` (required) uuid of buy or sell order

- **getopenorders($market)**

    Get all orders that you currently have opened. A specific market can be requested.

    `market` (optional) a string literal for the market (ex: BTC-LTC)

- **getbalances()**

    Used to retrieve all balances from your account.

- **getbalance($currency)**

    Used to retrieve the balance from your account for a specific currency.

    `currency` : (required) a string literal for the currency (ex: LTC)

- **getdepositaddress($currency)**

    Used to retrieve or generate an address for a specific currency. If one does not
    exist, the call will fail and return -1 until one is available.

    On success, returns the deposit address as a string.

    `currency` : (required) a string literal for the currency (ex: LTC)

- **withdraw($currency, $quantity, $address, $paymentid)**

    Used to withdraw funds from your account. note: please account for txfee.

    On success, returns the withdrawal UUID as a string.

    `currency` (required) a string literal for the currency (ie. BTC)
    `quantity` (required) the quantity of coins to withdraw
    `address` (required) the address where to send the funds.
    `paymentid` (optional) required for some currencies (memo/tag/etc)

- **getorder($uuid)**

    Used to retrieve a single order by uuid.

    `uuid` (required) the uuid of the buy or sell order

- **getorderhistory($market)**

    Used to retrieve your order history.

    `market` (optional) a string literal for the market (ie. BTC-LTC). If ommited, will return for all markets

- **getwithdrawalhistory($currency)**

    Used to retrieve your withdrawal history.

    `currency` (optional) a string literal for the currecy (ie. BTC). If omitted, will return for all currencies

- **getdeposithistory($currency)**

    Used to retrieve your deposit history.

    `currency` (optional) a string literal for the currecy (ie. BTC). If omitted, will return for all currencies

# AUTHOR

Developed and maintained by `jheddings`.

Tips are always appreciated!

- BTC - `1K6mkumfqTQTF4HJuLZAh1g8uRHQhWLomz`
- ETH - `0xA114CE80Fc995a993d5726a74DAf08ad8C739Af4`
- DASH - `XmTsc9qQQctrauq8zVXXoL9c8DKd29q2Gd`
- LTC - `LLscXRCUndQRjQdbTouvDE9NH5fiaanZzo`

# COPYRIGHT

Copyright (c) 2017 Jason Heddings

Licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT),
which is also included in the original source code of this project.
