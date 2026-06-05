// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DonationTracker{

    event DonationReceived(address indexed donor, uint256 amount);

    mapping(address => uint256) public donations ;

    uint256 public totalDonations;

    address[] public donors;


    function donate() public payable {
        require(msg.value > 0,"Donation must be greater than 0");
        
        if(donations[msg.sender] == 0){
            donors.push(msg.sender);
        }
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    function getDonorsCount() external view returns(uint256){
        return donors.length;
    }

}