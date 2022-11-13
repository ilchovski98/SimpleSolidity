// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract EtherWallet is Ownable {
    receive() external payable {}

    function withdraw(uint _amount) external isOwner {
        (bool success, bytes memory data) = payable(owner).call{value: _amount}("");
        require(success, "call failed");
    }
}
