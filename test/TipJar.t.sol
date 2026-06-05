// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/TipJar/TipJar.sol";

contract TipJarTest is Test {
    TipJar tipJar;
    address tipper = address(0x1);
    address receiver = address(0x2);

    function setUp() public {
        tipJar = new TipJar();
        vm.deal(tipper, 10 ether);
    }

    function test_TipSuccess() public {
        vm.prank(tipper);
        tipJar.tip{value: 1 ether}(receiver, "Great job!");

        // Receiver'ın bakiyesini kontrol et
        assertEq(receiver.balance, 1 ether);

        // Stats kontrolü
        (uint256 total, uint256 count) = tipJar.getTipperStats(receiver);
        assertEq(total, 1 ether);
        assertEq(count, 1);
    }

    function test_Fail_ZeroTip() public {
        vm.prank(tipper);
        vm.expectRevert("Tip amount must be greater than zero");
        tipJar.tip{value: 0}(receiver, "No money");
    }

    function test_GetTotalReceived() public {
        vm.prank(tipper);
        tipJar.tip{value: 0.5 ether}(receiver, "Tip 1");

        // receiver'ın kendi bakış açısıyla sorgulama
        vm.prank(receiver);
        assertEq(tipJar.getTotalReceived(), 0.5 ether);
    }
}