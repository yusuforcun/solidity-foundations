//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery{
    address public manager ;
    address payable[] public players;


    event LotteryEntered(address indexed player);
    event LotteryWinner(address indexed winner, uint256 amount);

    constructor(){
        manager = msg.sender;
    }

    function enter() public payable{
        require(msg.value > 0.01 ether,"Minimum amount to enter the lottery is 0.01 ether");
        players.push(payable(msg.sender));
        emit LotteryEntered(msg.sender);
    }

    function pickWinner() external {
        require(msg.sender == manager , "Only the manager can pick a winner");
        require(players.length > 0, "No players have entered the lottery");

        uint256 index = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length))) % players.length;
        
        address payable winner = players[index];
        uint256 prize = address(this).balance;

        (bool success,)  = winner.call{value : prize}("") ;
        require(success, "Transfer failed");

        emit LotteryWinner(winner, prize);

        delete players;
    }

    function getPlayers() public view returns (address payable[] memory){
        return players;
    }

}