pragma solidity ^0.4.0;

import "./lib/AddressUtils.sol";
import "./ToonInterface.sol";
import "./AccessControl.sol";

contract ToonsAggregator is AccessControl {
    using AddressUtils for address;

    event ToonFamilyAdded(uint _id, uint _name);

    ToonFamily[] toonFamilies;

    function addToonFamily(address _address) external onlyCOO {
        require(_address != 0x0);
        require(_address.isContract());

        ToonInterface _toonInterface = ToonInterface(_address);
        require(_toonInterface.isToonInterface());

        ToonFamily memory _family = ToonFamily(true, _toonInterface);
        uint id = toonFamilies.push(_family) - 1;

        emit ToonFamilyAdded(_id, _family.name());
    }

    struct ToonFamily {
        bool enabled;
        ToonInterface toonInterface;
    }
}
