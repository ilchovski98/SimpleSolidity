// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

contract PiggyBank {
    event Deposit(uint _amount);
    event Withdraw(uint _amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(owner == msg.sender, "must be owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
