// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Escrow{
    address public depositor ;
    address public beneficiary ;
    address public arbiter ;
    bool public isApproved ;

    constructor(address _arbiter , address _beneficiary){
        depositor = msg.sender ;
        beneficiary = _beneficiary ;
        arbiter = _arbiter ;
    }

    receive() external payable {}

    function approve()external{
        require(msg.sender == arbiter , "Only arbiter can approve");
        require(!isApproved , "Already approved");
        isApproved = true ;
    }

    function withdraw() external {
        require(isApproved , "Not approved yet");
        require(msg.sender == beneficiary , "Only beneficiary can withdraw");
        require(address(this).balance > 0 , "No funds to withdraw");

        uint256 balance = address(this).balance;
        (bool success , ) = beneficiary.call{value: balance}("");
        require(success , "Transfer failed");
    }


}