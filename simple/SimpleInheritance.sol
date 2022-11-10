// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function boo() public pure virtual returns (string memory) {
        return "A";
    }

    // more code here
    function baz() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public pure override returns (string memory) {
        return "B";
    }

    function boo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {
    function boo() public pure override returns (string memory) {
        return "C";
    }
}
