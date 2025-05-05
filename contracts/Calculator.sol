// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//  Make a contract called Calculator
//  Create result variable to store result
//  Create functions to add, subtract, and multiply to result
//  Create a function to get result

contract Calculator {
    uint256 result = 0;

    function add(uint256 num) public {
        result += num;
    }

    function subtract(uint256 num1) public {
        result -= num1;
    }

    function multiply(uint256 num2) public {
        result *= num2;
    }

    function divide(uint256 num3) public {
        result /= num3;
    }

    function get() public view returns(uint256) {
        return result;
    }
}