// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token{
    mapping(address => uint256) public balances ;

    event Transfer(address indexed from , address indexed to , uint256 amount);

    function mint(address to , uint256 amount) public {
        require(to != address(0),"Invalid recipient address");
        balances[to] += amount ;
        emit Transfer(address(0), to, amount);
    }

    function transfer(address to , uint256 amount)   external{
        require(to != address(0),"Invalid recipient address");
        require(balances[msg.sender] >= amount , "Insufficient balance");
        balances[msg.sender]-= amount ;
        balances[to] += amount ;
        emit Transfer(msg.sender, to, amount);
    }
}