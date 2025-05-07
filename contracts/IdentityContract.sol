//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import "./interfaces/IIdentityContract.sol";
import "./interfaces/IResponseRegistry.sol";

// Import hardhat console.log
import "hardhat/console.sol";

contract IdentityContract is AccessControl {
    event RequestProcessed(uint256 indexed requestId, bool skipped);

    uint256 private _lastProcessedRequestId = 0;

    IResponseRegistry private _responseRegistry;

    constructor(address defaultAdmin, address responseRegistryAddress) {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _responseRegistry = IResponseRegistry(responseRegistryAddress);
    }

    function grantAdminRole(address admin) public {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "Only admin can grant admin role"
        );
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function revokeAdminRole(address admin) public {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "Only admin can revoke admin role"
        );
        _revokeRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        console.logBytes4(interfaceId);

        return
            interfaceId == type(IIdentityContract).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function processRequest(
        uint256 requestId,
        string memory response,
        bool skipped
    ) external {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "Only admin can process request"
        );
        require(
            requestId == _lastProcessedRequestId + 1,
            "Request id must be incremented by 1"
        );
        _lastProcessedRequestId = requestId;

        if (skipped) return;

        _responseRegistry.addResponse(requestId, response);

        emit RequestProcessed(requestId, skipped);
    }

    function getLastProcessedRequestId() external view returns (uint256) {
        return _lastProcessedRequestId;
    }
}
