// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Voting/Voting.sol";

contract VotingTest is Test {
    Voting voting;
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        voting = new Voting();
    }

    function test_VoteYes() public {
        vm.prank(user1);
        voting.vote(true);

        assertEq(voting.yesVotes(), 1);
        assertTrue(voting.hasVoted(user1));
    }

    function test_VoteNo() public {
        vm.prank(user2);
        voting.vote(false);

        assertEq(voting.noVotes(), 1);
        assertTrue(voting.hasVoted(user2));
    }

    function test_Fail_DoubleVote() public {
        vm.startPrank(user1);
        voting.vote(true);
        
        vm.expectRevert("Already voted");
        voting.vote(false);
        vm.stopPrank();
    }
}