//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import "./interfaces/IIdentityContract.sol";

// Import hardhat console.log
import "hardhat/console.sol";

contract IdentityContract is AccessControl {
    event RequestProcessed(uint256 indexed requestId, bool skipped);
    
    uint256 private _lastProcessedRequestId = 0;

    constructor(address defaultAdmin) {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
    }

    function grantAdminRole(address admin) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can grant admin role");
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function revokeAdminRole(address admin) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can revoke admin role");
        _revokeRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        console.logBytes4(interfaceId);
        
        return
            interfaceId == type(IIdentityContract).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function processRequest(uint256 requestId, bool skipped) external {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can process request");
        require(requestId == _lastProcessedRequestId + 1, "Request id must be incremented by 1");

        _lastProcessedRequestId = requestId;
        emit RequestProcessed(requestId, skipped);

        // TODO: Process request
    }

    function getLastProcessedRequestId() external view returns (uint256) {
        return _lastProcessedRequestId;
    }
}