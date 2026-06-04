// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting{
    uint256 public yesVotes ;
    uint256 public noVotes ;

    mapping(address => bool) public hasVoted ;

    function vote(bool _choice) external{
        require(!hasVoted[msg.sender],"Already voted");

        if(_choice){
            yesVotes++ ;
        }else{
            noVotes++ ;
        }
        hasVoted[msg.sender]=true;
    }
}