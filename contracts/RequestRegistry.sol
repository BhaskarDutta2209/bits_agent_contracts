//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract RequestRegistry {
    struct Request {
        string[] doc_uris;
        string query;
        string[] assessment_parameters;
    }

    event RequestAdded(
        uint256 indexed requestId,
        string[] doc_uris,
        string query,
        string[] assessment_parameters
    );

    mapping(uint256 => Request) public requests;
    uint256 private _requestCount = 1;

    function addRequest(
        string[] memory doc_uris,
        string memory query,
        string[] memory assessment_parameters
    ) external {
        uint256 requestId = _requestCount;
        _requestCount++;

        requests[requestId] = Request(doc_uris, query, assessment_parameters);

        emit RequestAdded(requestId, doc_uris, query, assessment_parameters);
    }

    function getRequest(
        uint256 requestId
    )
        external
        view
        returns (
            string[] memory doc_uris,
            string memory query,
            string[] memory assessment_parameters
        )
    {
        return (
            requests[requestId].doc_uris,
            requests[requestId].query,
            requests[requestId].assessment_parameters
        );
    }

    function getTotalRequestCount() external view returns (uint256) {
        return _requestCount - 1;
    }
}
