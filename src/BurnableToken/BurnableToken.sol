// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BurnableToken {

    event Burn(address indexed burner, uint256 amount);

    mapping(address => uint256) public balances;

    uint256 public totalSupply;

    function burn(uint256 _amount) external{
        require(_amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender]>=_amount,"Insufficient balance");

        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Burn(msg.sender, _amount);
    }
}