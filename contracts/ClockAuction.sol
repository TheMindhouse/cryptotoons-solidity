pragma solidity 0.4.24;

import "./ClockAuctionBase.sol";

/// @title Clock auction for non-fungible tokens.
/// @notice We omit a fallback function to prevent accidental sends to this contract.

contract ClockAuction is ClockAuctionBase {

    /// @dev The ERC-165 interface signature for ERC-721.
    ///  Ref: https://github.com/ethereum/EIPs/issues/165
    ///  Ref: https://github.com/ethereum/EIPs/issues/721
    bytes4 constant InterfaceSignature_ERC721 = bytes4(0x9a20483d);

    bool public isSaleClockAuction = true;

    /// @dev Constructor creates a reference to the NFT ownership contract
    ///  and verifies the owner cut is in the valid range.
    /// @param _ownerCut - percent cut the owner takes on each auction, must be
    ///  between 0-10,000.
    /// @param _authorShare - percent share of the author of the toon.
    ///  Calculated from the ownerCut
    constructor(uint256 _ownerCut, uint256 _authorShare) public {
        require(_ownerCut <= 10000);
        require(_authorShare <= 10000);

        ownerCut = _ownerCut;
        authorShare = _authorShare;
    }

    /// @dev Creates and begins a new auction.
    /// @param _tokenId - ID of token to auction, sender must be owner.
    /// @param _startingPrice - Price of item (in wei) at beginning of auction.
    /// @param _endingPrice - Price of item (in wei) at end of auction.
    /// @param _duration - Length of time to move between starting
    ///  price and ending price (in seconds).
    /// @param _seller - Seller, if not the message sender
    function createAuction(
        address _contract,
        uint256 _tokenId,
        uint256 _startingPrice,
        uint256 _endingPrice,
        uint256 _duration,
        address _seller
    )
    external
    whenNotPaused
    {
        require(_isAddressSupportedContract(_contract));
        // Sanity check that no inputs overflow how many bits we've allocated
        // to store them in the auction struct.
        require(_startingPrice == uint256(uint128(_startingPrice)));
        require(_endingPrice == uint256(uint128(_endingPrice)));
        require(_duration == uint256(uint64(_duration)));

        _escrow(_contract, _seller, _tokenId);

        Auction memory auction = Auction(
            _contract,
            _seller,
            uint128(_startingPrice),
            uint128(_endingPrice),
            uint64(_duration),
            uint64(now)
        );
        _addAuction(_contract, _tokenId, auction);
    }

    /// @dev Bids on an open auction, completing the auction and transferring
    ///  ownership of the NFT if enough Ether is supplied.
    /// @param _tokenId - ID of token to bid on.
    function bid(address _contract, uint256 _tokenId)
    external
    payable
    whenNotPaused
    {
        // _bid will throw if the bid or funds transfer fails
        _bid(_contract, _tokenId, msg.value);
        _transfer(_contract, msg.sender, _tokenId);
    }

    /// @dev Cancels an auction that hasn't been won yet.
    ///  Returns the NFT to original owner.
    /// @notice This is a state-modifying function that can
    ///  be called while the contract is paused.
    /// @param _tokenId - ID of token on auction
    function cancelAuction(address _contract, uint256 _tokenId)
    external
    {
        Auction storage auction = tokenToAuction[_contract][_tokenId];
        require(_isOnAuction(auction));
        address seller = auction.seller;
        require(msg.sender == seller);
        _cancelAuction(_contract, _tokenId, seller);
    }

    /// @dev Cancels an auction when the contract is paused.
    ///  Only the owner may do this, and NFTs are returned to
    ///  the seller. This should only be used in emergencies.
    /// @param _tokenId - ID of the NFT on auction to cancel.
    function cancelAuctionWhenPaused(address _contract, uint256 _tokenId)
    whenPaused
    onlyOwner
    external
    {
        Auction storage auction = tokenToAuction[_contract][_tokenId];
        require(_isOnAuction(auction));
        _cancelAuction(_contract, _tokenId, auction.seller);
    }

    /// @dev Returns auction info for an NFT on auction.
    /// @param _tokenId - ID of NFT on auction.
    function getAuction(address _contract, uint256 _tokenId)
    external
    view
    returns
    (
        address seller,
        uint256 startingPrice,
        uint256 endingPrice,
        uint256 duration,
        uint256 startedAt,
        uint256 currentPrice
    ) {
        Auction storage auction = tokenToAuction[_contract][_tokenId];

        //It returns auction even if token is not for sale. Then startedAt = 0
//        require(_isOnAuction(auction));

        return (
        auction.seller,
        auction.startingPrice,
        auction.endingPrice,
        auction.duration,
        auction.startedAt,
        getCurrentPrice(_contract, _tokenId)
        );
    }

    /// @dev Returns the current price of an auction.
    /// @param _tokenId - ID of the token price we are checking.
    function getCurrentPrice(address _contract, uint256 _tokenId)
    public
    view
    returns (uint256)
    {
        Auction storage auction = tokenToAuction[_contract][_tokenId];
        require(_isOnAuction(auction));
        return _currentPrice(auction);
    }

}
