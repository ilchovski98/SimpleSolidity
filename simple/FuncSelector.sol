// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FunctionSelector {
    // input "transfer(address,uint256)"
    // output 0xa9059cbb
  function getSelector(string calldata _func) external pure returns (bytes4) {
    return bytes4(keccak256(bytes(_func)));
  }
}

contract Receiver {
  event Log(bytes data);

  function transfer(address _to, uint _amount) external {
    emit Log(msg.data);
    //0xa9059cbb
    //0000000000000000000000004b20993bc481177ec7e8f571cecae8a9e22c02db
    //0000000000000000000000000000000000000000000000000000000000000002
  }
}
