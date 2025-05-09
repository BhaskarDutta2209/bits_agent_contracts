//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract ResponseRegistry {
    struct Response {
        address modelAddress;
        string response;
    }

    mapping(uint256 => Response[]) public responses;
    mapping(uint256 => string) public summary;
    uint256[] public requestsPendingSummmarization;


    event ResponseAdded(
        uint256 indexed requestId,
        address modelAddress,
        string response
    );

    constructor() {}

    function _enqueueRequestPendingSummarization(uint256 requestId) internal {
        requestsPendingSummmarization.push(requestId);
    }

    function _dequeueRequestPendingSummarization() internal returns (uint256) {
        uint256 requestId = requestsPendingSummmarization[0];
        delete requestsPendingSummmarization[0];
        return requestId;
    }

    function addResponse(uint256 requestId, string memory response) external {
        uint256 previous_length = responses[requestId].length;
        responses[requestId].push(Response(msg.sender, response));

        uint256 current_length = responses[requestId].length;
        require(current_length == previous_length + 1, "Invalid response");

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

    function provideSummarization(uint256 requestId, string memory _summary) external {
        summary[requestId] = _summary;
    }
}
