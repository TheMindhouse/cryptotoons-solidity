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

## Quick Family creation via Remix

The least _pro_ way to upload the contract, but the fastest if you don't have the environment setup on your computer. 
1. Got to https://remix.ethereum.org/
2. Add the all the code in one file (`dl` directory). 
3. Compile using the compiler version from the code. 
4. Log in to the injected Web3 provider (MetaMask)
5. Deploy `CryptoToon.sol` contract to the main network as visible on the screenshot. The null address it `0x0000000000000000000000000000000000000000`. 
6. Verify the contract code. If the code is unchanged etherscan seems to auto-verify the contract based on previously existing toons contracts. 
7. Use `addToonContract` to register newly created toon on the auction contract (0xaaa688ac2755cb6a27d123a0300bcf793c9ed019)
8. 🎉 Earn money 💰

![image](https://user-images.githubusercontent.com/9295935/129236746-80d917c7-6a0f-4361-9b56-d3d35b0c08ba.png)
