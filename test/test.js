import {ToonBase} from "./wrapper/ToonBase";

const CryptoToon = artifacts.require("./CryptoToon.sol");
const BigNumber = require('bignumber.js');


contract('Example test', async (accounts) => {

    let toon;

    before(async () => {
        toon = new ToonBase(await CryptoToon.deployed());
    });

    it("should be empty when deployed", async () => {
        const maxSupply = await toon.maxSupply();
        console.log(maxSupply);
    });

});
