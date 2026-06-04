// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DepositVault{
    mapping(address => uint256) public balances ;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0 , "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value ;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount , "Insufficient funds");
        require(_amount > 0 , "Withdraw amount must be greater than zero");
        balances[msg.sender] -= _amount;
        (bool success,) = msg.sender.call{value: _amount}("");
        require(success, "Withdrawal failed");

        emit Withdrawn(msg.sender, _amount);
    } 
}