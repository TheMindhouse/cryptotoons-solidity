# Crypto Toons contract 

[![Build Status](https://travis-ci.com/TheMindhouse/cryptotoons-solidity.svg?branch=master)](https://travis-ci.com/TheMindhouse/cryptotoons-solidity)

Contract code for [CryptoToons](https://cryptotoons.io).

To run code locally, you need `truffle` and `ganache`. First start _ganache_:

`ganache-cli --gasLimit 7000000`

And then run truffle migrations that will publish contracts: 

`truffle migrate --compile-all --network dev --reset`

## Publishing to Rinkeby network

Over [here](https://blog.abuiles.com/blog/2017/07/09/deploying-truffle-contracts-to-rinkeby/) you can find nice tutorial how to publish contract to the Rinkeby network. 

First of all, you need `geth` installed. Secondly, truffle is configured to run transactions from `0x329fE1d35FFE409bA2E0DFFF99D57555CA656EB4` address. To change it modify `truffle.js` file. 

To run migrations, start `geth` and unlock configured address: 

`geth --rinkeby --rpc --rpcapi db,eth,net,web3,personal --unlock="0x329fE1d35FFE409bA2E0DFFF99D57555CA656EB4"`

Then, run migrations: 

`truffle migrate --network rinkeby`