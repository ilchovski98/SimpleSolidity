// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

library Math {
    function max(uint _x, uint _y) internal pure returns(uint) {
        return _x >= _y ? _x : _y;
    }
}

contract Example {
    using Math for uint;

    function compare(uint _x, uint _y) external pure returns(uint) {
        // return Math.max(_x, _y);
        return _x.max(_y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint _x) internal view returns(uint) {
        for(uint _i = 0; _i < arr.length; _i++) {
            if (arr[_i] == _x) {
                return _x;
            }
        }

        revert("not found");
    }
}

contract TestArray {
    using ArrayLib for uint[];
    uint[] public arr = [3, 2, 1];

    function testFind() external view returns(uint) {
        return arr.find(2);
        // return ArrayLib.find(arr, 2);
    }
}
