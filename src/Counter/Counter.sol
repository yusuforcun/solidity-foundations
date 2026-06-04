// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter{
    uint256 public count ;

    function increment()external{
        count++ ;
    }

    function decrement() external{
        require(count >0 ,"Counter is already at zero");
        count-- ;
    }
}