// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract SimpleArrays {
    uint256[] public notFixedArr = [1, 2, 3, 4];
    uint256[3] public fixedArr = [0, 2, 5];
    uint256[] public testArr = [1, 2, 3, 4, 5];

    function addElementToArr(uint256 _x) external {
        notFixedArr.push(_x);
    }

    function removeElementFromArrIndex(uint256 _x) external {
        delete notFixedArr[_x];
    }

    function popElementFromArrIndex() external {
        notFixedArr.pop();
    }

    function getArrLength() external view returns (uint256){
        return notFixedArr.length;
    }

    function createArrInMemory() external {
        uint[] memory someArr = new uint[](3);
    }

    function returnTestArr() external view returns (uint[] memory) {
        return testArr;
    }

    function remove(uint _index) public {
        require(_index < testArr.length, "index out of bound");

        for (uint i = _index; i < testArr.length - 1; i++) {
            testArr[i] = testArr[i + 1];
        }

        testArr.pop();
    }

    function efficientRemove(uint _index) public {
        require(_index < testArr.length, "index out of bound");

        testArr[_index] = testArr[testArr.length - 1];
        testArr.pop();
    }


    function test() external {
        testArr = [1, 2, 3, 4];
        remove(2);

        assert(testArr[0] == 1);
        assert(testArr[1] == 2);
        assert(testArr[2] == 4);
        assert(testArr.length == 3);

        testArr = [1];
        remove(0);
        assert(testArr.length == 0);
    }
}
