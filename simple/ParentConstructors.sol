// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

// 2 ways to call parent constructors
// Order of initialization

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// If you know the constructor values when writing the code
contract U is S("s"), T("t") {

}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// The order of execution depends the "is S, T"
contract VV is S("s"), T {
    constructor(string memory _name, string memory _text) T(_text) {

    }
}
