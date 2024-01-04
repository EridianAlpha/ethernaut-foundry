// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";

contract ParseHexString is Script {
    // Helper function to parse a hex string as an Ethereum address
    function parseHexString(
        string memory _a
    ) internal pure returns (address _parsedAddress) {
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i = 2; i < 2 + 2 * 20; i += 2) {
            iaddr *= 256;
            b1 = uint160(uint8(tmp[i]));
            b2 = uint160(uint8(tmp[i + 1]));
            if ((b1 >= 97) && (b1 <= 102)) b1 -= 87;
            else if ((b1 >= 65) && (b1 <= 70))
                b1 -= 55; // handle upper case letters
            else if ((b1 >= 48) && (b1 <= 57)) b1 -= 48;
            if ((b2 >= 97) && (b2 <= 102)) b2 -= 87;
            else if ((b2 >= 65) && (b2 <= 70))
                b2 -= 55; // handle upper case letters
            else if ((b2 >= 48) && (b2 <= 57)) b2 -= 48;
            iaddr += (b1 * 16 + b2);
        }
        return address(iaddr);
    }
}

contract GetInstanceAddress is Script, ParseHexString {
    function getInstanceAddress() internal view returns (address) {
        string memory contractAddressStr = vm.envString("CONTRACT_ADDRESS");
        require(
            bytes(contractAddressStr).length > 0,
            "Contract address not provided"
        );

        address targetContractAddress = parseHexString(contractAddressStr);
        require(
            targetContractAddress != address(0),
            "Invalid contract address"
        );

        return targetContractAddress;
    }
}
