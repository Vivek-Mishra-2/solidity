// get funds from users
// withdraw funds
// set a minimum funding value in USD 


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    
    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How to we send ETH to this transactions
        require(msg.value > 1e18, "Did not send enough!"); // 1e18 = 1*10*18 = 1 eth

    }

    // function withdraw() {

    // }
}