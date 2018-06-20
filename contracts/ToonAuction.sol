pragma solidity ^0.4.24;

import "./ToonMinting.sol";
import "./ClockAuction.sol";

contract ToonAuction is ToonMinting {

    ClockAuction public saleAuction;

    function setSaleAuctionAddress(address _address) external onlyCEO {
        ClockAuction candidateContract = ClockAuction(_address);
        require(candidateContract.isSaleClockAuction());

        // Set the new contract address
        saleAuction = candidateContract;
    }

    function createSaleAuction(
        uint256 _toonId,
        uint256 _startingPrice,
        uint256 _endingPrice,
        uint256 _duration
    )
    external
    whenNotPaused
    {
        // Auction contract checks input sizes
        // If toon is already on any auction, this will throw
        // because it will be owned by the auction contract.
        require(ownerOf(_toonId) == msg.sender);
        approve(saleAuction, _toonId);

        // Sale auction throws if inputs are invalid and clears
        // transfer approval after escrowing the toon.
        saleAuction.createAuction(
            this,
            _toonId,
            _startingPrice,
            _endingPrice,
            _duration,
            msg.sender
        );
    }

}
