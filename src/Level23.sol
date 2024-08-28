// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// ================================================================
// │                        LEVEL 23 - DEX TWO                    │
// ================================================================
contract AttackToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("AttackToken", "ATK") {
        _mint(msg.sender, initialSupply);
    }
}
