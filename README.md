# Crypto Toons contract 

[![Build Status](https://travis-ci.com/TheMindhouse/cryptotoons-solidity.svg?branch=master)](https://travis-ci.com/TheMindhouse/cryptotoons-solidity)

Contract code for [CryptoToons](https://cryptotoons.io).

To run code locally, you need `truffle` and `ganache`. First start _ganache_:

`ganache-cli --gasLimit 7000000`

And then run truffle migrations that will publish contracts: 

`truffle migrate --compile-all --network dev --reset`
