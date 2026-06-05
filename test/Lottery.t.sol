// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Lottery/Lottery.sol";


contract LotteryTest is Test {
    Lottery lottery;
    address manager = address(this); // Test kontratı manager olsun
    address player1 = address(0x1);
    address player2 = address(0x2);

    function setUp() public {
        lottery = new Lottery();
    }

    function test_EnterLottery() public {
        vm.deal(player1, 1 ether);
        vm.prank(player1);
        lottery.enter{value: 0.011 ether}();

        assertEq(lottery.getPlayers().length, 1);
        assertEq(lottery.getPlayers()[0], player1);
    }

    function test_Fail_LowEntryAmount () public {
        vm.prank(player1);
        vm.expectRevert();
        lottery.enter{value: 0.005 ether}();
    }

    function test_PickWinner() public {
        vm.deal(player1 , 1 ether);
        vm.deal(player2 , 1 ether);

        vm.prank(player1);
        lottery.enter{value : 0.011 ether}();

        vm.prank(player2);
        lottery.enter{value : 0.011 ether}();

        uint256 balanceBeforeP1 = player1.balance ;
        uint256 balanceBeforeP2 = player2.balance ;

        lottery.pickWinner();

        assertTrue(player1.balance > balanceBeforeP1 || player2.balance > balanceBeforeP2);

        assertEq(lottery.getPlayers().length , 0 );
    }

    function test_Fail_NotManager() public {
        vm.prank(player1);
        vm.expectRevert("Only the manager can pick a winner");
        lottery.pickWinner();
    }


}
