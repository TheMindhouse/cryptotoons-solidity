pragma solidity 0.4.24;

import "./erc/ERC721.sol";

/**
* @dev  interface to communicate with any implementation of toon.
*       In the future we may release toons that will behave different
*       than current implementation.
*/
contract ToonInterface is ERC721 {

    function isToonInterface() external pure returns (bool);

    /**
    * @notice   Returns maximum supply. In other words there will
    *           be never more toons that that number. It has to
    *           be constant.
    *           If there is no limit function returns 0.
    */
    function maxSupply() external view returns (uint256);

    function getToonInfo(uint _id) external view returns (
        uint genes,
        uint birthTime,
        address owner
    );

}