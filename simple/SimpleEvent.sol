// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract SimpleEvent {
    event Log(string message, uint val);
    // up to 3 index
    event IndexedLog(address indexed sender, uint val);

    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 1234);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
