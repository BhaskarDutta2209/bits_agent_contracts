//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract ResponseRegistry {
    struct Response {
        address modelAddress;
        string response;
    }

    mapping(uint256 => Response[]) public responses;

    event ResponseAdded(
        uint256 indexed requestId,
        address modelAddress,
        string response
    );

    constructor() {}

    function addResponse(uint256 requestId, string memory response) external {
        responses[requestId].push(Response(msg.sender, response));

        emit ResponseAdded(requestId, msg.sender, response);
    }

    function getResponseCount(
        uint256 requestId
    ) external view returns (uint256) {
        return responses[requestId].length;
    }

    function getResponse(
        uint256 requestId,
        uint256 responseIndex
    ) external view returns (address modelAddress, string memory response) {
        return (
            responses[requestId][responseIndex].modelAddress,
            responses[requestId][responseIndex].response
        );
    }
}
