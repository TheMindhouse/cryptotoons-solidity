const SaleAuction = artifacts.require("./ClockAuction.sol");
const CryptoToon = artifacts.require("./CryptoToon.sol");

module.exports = function (deployer) {
    deployer.deploy(SaleAuction, 500, 5000);
    deployer.deploy(CryptoToon, "toon", "CTN", 100, 100, "0x0")
        .then(instance => {
            instance.setSaleAuctionAddress(SaleAuction.address);
        })
};
