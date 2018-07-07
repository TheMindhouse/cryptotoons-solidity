import {CryptoToonWrapper} from "./wrapper/CryptoToonWrapper";
import {ClockAuctionWrapper} from "./wrapper/ClockAuctionWrapper";

const CryptoToon = artifacts.require("./CryptoToon.sol");
const ClockAuction = artifacts.require("./ClockAuction.sol");
const BigNumber = require('bignumber.js');

const chai = require('chai');
chai.use(require('chai-as-promised')).should();
chai.use(require('chai-arrays')).should();


/**
 * It's a temporary test suite that simply checks if everything
 * seem to work. More tests to be written.
 */
contract('Basic test suite', async (accounts) => {

    let toon;
    let saleAuction;

    before(async () => {
        toon = new CryptoToonWrapper(await CryptoToon.deployed());
        saleAuction = new ClockAuctionWrapper(await ClockAuction.deployed())
    });

    it("should create toon", async () => {
        let totalSupply = await toon.totalSupply();
        totalSupply.eq(0).should.be.true;

        await toon.createPromoToon(10);
        totalSupply = await toon.totalSupply();
        totalSupply.eq(1).should.be.true;

        const promoMinted = await toon.promoToonsMinted();
        promoMinted.should.be.eq(1);
    });

    it("should get toon info", async () => {
        const info = await toon.getToonInfo(0);
        info.owner.should.be.eq(accounts[0]);
    });

    it("should put toon on auction", async () => {
        let auction = await saleAuction.getAuction(toon.address, 0);
        auction.startedAt.eq(0).should.be.true

        await toon.createSaleAuction(0, 1000000, 0, 6000);

        auction = await saleAuction.getAuction(toon.address, 0);
        auction.seller.should.be.eq(accounts[0]);
        auction.duration.eq(6000).should.be.true;
    });

    it("should buy a toon", async () => {
        await saleAuction.bid(toon.address, 0, {from: accounts[9], value: 1000000});
        const info = await toon.getToonInfo(0);

        info.owner.should.be.eq(accounts[9]);
    });

});
