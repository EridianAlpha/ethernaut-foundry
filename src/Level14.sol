// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

// ================================================================
// │                    LEVEL 14 - GATEKEEPER TWO                 │
// ================================================================
contract GatekeeperTwoMiddleman {
    constructor(address targetContract) {
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(0xffffffffffffffff));
        (bool success,) = address(targetContract).call(abi.encodeWithSignature("enter(bytes8)", key));
        require(success);
    }
}
