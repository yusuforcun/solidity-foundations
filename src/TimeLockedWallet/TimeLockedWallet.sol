// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockedWallet{
    struct Deposit{
        uint256 amount ;
        uint256 unlockTime;
    }

    mapping(address => Deposit) public deposits ;

    function deposit(uint256 _duration) external payable{
        require(msg.value > 0 , "Deposit amount must be greater than zero");
        require(deposits[msg.sender].amount == 0 , "Existing deposit found.");
        deposits[msg.sender] = Deposit(msg.value , block.timestamp + _duration);
    }

    function withdraw() external{
        Deposit storage d = deposits[msg.sender];
        require(block.timestamp >= d.unlockTime,"Funds are still locked");

        uint256 amountToWithdraw = d.amount ;
        require(d.amount > 0 ,"No fund to withdraw");

        d.amount = 0 ;

        payable(msg.sender).transfer(amountToWithdraw);
    }
}