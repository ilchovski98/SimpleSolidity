// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

// Delegate call is used to update smart contract logic
// DelegateCall contract is the one that stays the same but we can update TestDelegateCall and use its new address
// We have to be careful not to change the order of the variables in TestDelegateCall or to add new before the odl ones
// because we will change the storage
// So when we delegate call and the storage is changed we will get very weird results because the Storage of
// DelegateCall haven't changed but the TestDelegateCall have changed.
// delegatecall executes TestDelegateCall's function in the context of DelegateCall

contract TestDelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _x) external payable {
        num = _x;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _x) external payable {
        // _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );

        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _x)
        );

        require(success, "delegate call failed");
    }
}
