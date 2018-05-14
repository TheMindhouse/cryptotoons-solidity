pragma solidity ^0.4.0;

import "./ToonMinting.sol";
import "./ToonInterface.sol";

contract CryptoToons is ToonMinting, ToonInterface {

    //TODO should all the toons have the same symbol??
    constructor(string _name, string _symbol, uint _maxSupply, uint32 _maxPromoToons)
    public
    ToonMinting(_name, _symbol, _maxSupply, _maxPromoToons) {
    }

    function getToonInfo(uint _id) external view returns (
        uint genes,
        uint birthTime,
        address owner
    ) {
        Toon memory _toon = _getToon(_id);
        return (toon.genes, toon.birthTime, ownerOf(_id));
    }

}
