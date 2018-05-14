pragma solidity ^0.4.23;

import "./erc/ERC721Token.sol";
import "./AccessControl.sol";

contract ToonBase is ERC721Token, AccessControl {

    Toon[] private toons;
    uint public maxSupply;
    uint32 public maxPromoToons;

    constructor(string _name, string _symbol, uint _maxSupply, uint32 _maxPromoToons)
    public
    ERC721Token(_name, _symbol) {
        maxSupply = _maxSupply;
        maxPromoToons = _maxPromoToons;
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return toons.length;
    }

    /**
     * @dev Returns an URI for a given token ID
     * @dev Throws if the token ID does not exist. May return an empty string.
     * @param _tokenId uint256 ID of the token to query
     */
    function tokenURI(uint256 _tokenId) public view returns (string) {
        //TODO implement
        revert();
    }

    function _getToon(uint _id) internal view returns (Toon){
        require(_id <= totalSupply());
        return toons[_id];
    }

    function _createToon(uint _genes, address _owner) internal {
        Toon memory _toon = Toon(_genes, now);
        uint id = toons.push(_toon) - 1;

        _mint(_owner, id);
    }

    struct Toon {
        uint256 genes;

        uint256 birthTime;
    }
}
