// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Faucet{

    uint256 public constant WITHDRAW_AMOUNT = 0.01 ether;
    uint256 public constant COOLDOWN = 1 days ;

    mapping(address =>uint256) public lastWithdrawTime ;

    receive() external payable {}

    function withdraw() external {

        require(
            block.timestamp >= lastWithdrawTime[msg.sender] + COOLDOWN,
            "Cooldown active"
        );

        require(
            address(this).balance >= WITHDRAW_AMOUNT , 
            "Insufficient faucet balance"
        );

        lastWithdrawTime[msg.sender] = block.timestamp ;

        payable(msg.sender).transfer(WITHDRAW_AMOUNT);
    }

    function getBalance() external view returns ( uint256 ){
        return address(this).balance ;
    }
    
    }