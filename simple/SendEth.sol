// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract SendEth {
    // Make contract to receive ETH
    // Send ether when contract is deployed: constructor() payable {}
    // fallback() external payable {}
    receive() external payable {}

    // transfer - 2300 gas - reverts
    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(msg.value);
    }

    // send - 2300 gas - returns bool - many contracts would never use send. They use either transfer or call
    function sendViaSend(address payable _to) external payable {
       bool sent = _to.send(msg.value);
       require(sent, "Send failed");
    }
    // call - all gas - returns data and bool
    function sendViaCall(address payable _to) external payable {
        // (bool success, bytes memory data) = _to.call{value: 123}("");
        (bool success,) = _to.call{value: msg.value}("");
        require(success, "Call failed");
    }
}

contract EthReceiver is Ownable {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    function withdraw() external isOwner {
        payable(owner).transfer(address(this).balance);
    }
}
