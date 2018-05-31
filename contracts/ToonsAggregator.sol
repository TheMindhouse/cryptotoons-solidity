pragma solidity ^0.4.24;

import "./lib/AddressUtils.sol";
import "./ToonInterface.sol";
import "./AccessControl.sol";

contract ToonsAggregator is AccessControl {
    using AddressUtils for address;

    event ToonFamilyAdded(uint indexed _id, string _name);

    ToonFamily[] toonFamilies;

    function addToonFamily(address _address) external onlyCOO {
        require(_address != 0x0);
        require(_address.isContract());

        ToonInterface _toonInterface = ToonInterface(_address);
        require(_toonInterface.isToonInterface());

        ToonFamily memory _family = ToonFamily(true, _toonInterface);
        uint _id = toonFamilies.push(_family) - 1;

        emit ToonFamilyAdded(_id, _toonInterface.name());
    }

    struct ToonFamily {
        bool enabled;
        ToonInterface toonInterface;
    }
}
