// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AllowListSystem{
    mapping(address => bool) public isAllowed ;
    address public owner ;

    event AddedToAllowList(address indexed account);
    event RemovedFromAllowList(address indexed account);

    constructor(){
        owner = msg.sender ;
    }
    
    
    modifier onlyAllowed(){
        require(isAllowed[msg.sender],"Not allowed");
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "Only owner can perform this action");
        _;
    }

    
    function addToAllowList(address _address) public {
        require(_address != address(0), "Invalid address");
        require(msg.sender == owner , "Only owner can add to allow list");
        isAllowed[_address] = true ;
        emit AddedToAllowList(_address);
    }

    function removeFromAllowList(address _address) public {
        require(msg.sender == owner , "Only owner can remove from allow list");
        isAllowed[_address] = false ;
        emit RemovedFromAllowList(_address);
    }

    function restrictedFunction() public onlyAllowed{
        // Function logic here
    }





}