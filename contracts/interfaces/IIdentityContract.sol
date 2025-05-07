//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

interface IIdentityContract is IERC165 {
    function grantAdminRole(address admin) external;
    function revokeAdminRole(address admin) external;
    function processRequest(uint256 requestId, string memory response, bool skipped) external;
    function getLastProcessedRequestId() external view returns (uint256);
}