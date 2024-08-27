// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                      LEVEL 18 - MAGIC NUMBER                 │
// ================================================================
interface IMagicNum {
    function setSolver(address _solver) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();

        // Store the contract bytecode
        bytes memory bytecode = hex"600a600c600039600a6000f3602a60505260206050f3";

        // Deploy the contract using create
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        // Set the solver address
        IMagicNum(targetContractAddress).setSolver(address(deployedAddress));

        vm.stopBroadcast();
    }
}
