pragma solidity ^0.4.24;

import "./ToonBase.sol";
import "./lib/SafeMath32.sol";

contract ToonMinting is ToonBase {
    using SafeMath32 for uint32;

    uint32 public promoToonsMinted = 0;

    constructor(string _name, string _symbol, uint _maxSupply, uint32 _maxPromoToons, address _author)
    public
    ToonBase(_name, _symbol, _maxSupply, _maxPromoToons, _author) {
    }

    function createPromoToon(uint _genes, address _owner) external onlyCOO {
        require(promoToonsMinted < maxPromoToons);
        address _toonOwner = _owner;
        if (_toonOwner == 0x0) {
            _toonOwner = cooAddress;
        }

        _createToon(_genes, _toonOwner);
        promoToonsMinted = promoToonsMinted.add(1);
    }

}
