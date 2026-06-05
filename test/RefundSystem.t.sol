// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/RefundSystem/RefundSystem.sol";

contract RefundSystemTest is Test {

    RefundSystem rs;
    address user1 = address(0x1);
    uint256 goal = 1 ether;
    uint256 duration = 7 days;

    function setUp() public {
        rs = new RefundSystem(goal, duration);
    }

    function test_Contribute() public {
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        rs.contribute{value: 0.5 ether}();

        assertEq(rs.contributions(user1), 0.5 ether);
        assertEq(rs.totalRaised(), 0.5 ether);
    }

    function test_RefundableState() public {
        // Hedefe ulaşılamadan süre doldu
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        rs.contribute{value: 0.1 ether}();

        // Süreyi bitir
        vm.warp(block.timestamp + duration + 1);
        rs.checkState();

        assertEq(uint(rs.currentState()), uint(RefundSystem.State.Refundable));

        // Refund yap
        uint256 beforeBalance = user1.balance;
        vm.prank(user1);
        rs.refund();

        assertEq(user1.balance, beforeBalance + 0.1 ether);
        assertEq(rs.contributions(user1), 0);
    }

    function test_Fail_ActiveRefund() public {
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        rs.contribute{value: 0.1 ether}();

        // Durum henüz Active, refund olmamalı
        vm.expectRevert("Not refundable");
        rs.refund();
    }
    
}