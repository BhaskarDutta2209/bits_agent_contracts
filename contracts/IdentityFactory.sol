//SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./IdentityContract.sol";

contract IdentityFactory {
    event ModelRegistered(
        address indexed registrarAddress, 
        address indexed modelAddress
    );

    constructor() {}

    function registerModel(address responseRegistryAddress) 
        external 
        returns (address) 
    {
        IdentityContract newModel = 
            new IdentityContract(
                msg.sender, 
                responseRegistryAddress
            );
        emit ModelRegistered(msg.sender, address(newModel));

        return address(newModel);
    }
}