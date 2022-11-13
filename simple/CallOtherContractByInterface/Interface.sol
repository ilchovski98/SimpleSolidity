// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

interface ICounter {
    function count() external view returns(uint);
    function inc() external;
}

contract CallInterface {
    uint public count;
    // By contract
    // function examples(address _counter) external {
    //     Counter(_counter).inc();
    //     count = Counter(_counter).count();
    // }

    // By interface
    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
