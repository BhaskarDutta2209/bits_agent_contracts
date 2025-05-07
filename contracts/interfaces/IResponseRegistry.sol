//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

interface IResponseRegistry {
    function addResponse(uint256 requestId, string memory response) external;
    function getResponseCount(uint256 requestId) external view returns (uint256);
    function getResponse(uint256 requestId, uint256 responseIndex) external view returns (address modelAddress, string memory response);
}