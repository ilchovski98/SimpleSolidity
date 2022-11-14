// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

// encode returns the full version of the encoding
// encodePacked removes the empty spaces
// with encodePacked we can see collisions if we have 2 dynamic args next to each other
// for Example test "AAA" and "BBB" vs "AA" and "ABBB" - it will return the same encoding (packed)

contract HashFunc {
    function hash(string memory text, uint num, address addr) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(string memory text0, string memory text1) external pure returns(bytes memory) {
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1) external pure returns(bytes memory) {
        return abi.encodePacked(text0, text1);
    }

    function collision(string memory text0, uint x, string memory text1) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text0, x, text1));
    }
}
