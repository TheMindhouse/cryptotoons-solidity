pragma solidity ^0.4.24;

import "./ToonBase.sol";
import "./lib/SafeMath32.sol";

contract ToonMinting is ToonBase {
    using SafeMath32 for uint32;

    uint32 promoToonsMinted = 0;

    constructor(string _name, string _symbol, uint _maxSupply, uint32 _maxPromoToons)
    public
    ToonBase(_name, _symbol, _maxSupply, _maxPromoToons) {
    }

    function createPromoToon(uint _genes, address _owner) external onlyCOO {
        require(promoToonsMinted < maxPromoToons);
        address _toonOwner = _owner;
        if (_toonOwner == 0x0) {
            _toonOwner = cooAddress;
        }

        _createToon(_genes, _owner);
        promoToonsMinted.add(1);
    }

}
