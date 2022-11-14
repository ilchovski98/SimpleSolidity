// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract isContract {
  function isContract(address _account) internal view returns(bool) {
    uint size;
    assembly { size := extcodessize(_account)}
    return size > 0;
  }
}
