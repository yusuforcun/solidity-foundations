// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/DonationTracker/DonationTracker.sol";

contract DonationTrackerTest is Test {
    DonationTracker tracker ;
    address donor1 = address(0x1);
    address donor2 = address(0x2);

    function setUp() public {
        tracker = new DonationTracker();
        vm.deal(donor1 , 10 ether);
        vm.deal(donor2 , 10 ether);
    }

    function test_Donate() public {
        vm.prank(donor1);
        tracker.donate{value : 1 ether}();

        assertEq(tracker.donations(donor1) , 1 ether);
        assertEq(tracker.totalDonations() , 1 ether);
        assertEq(tracker.getDonorsCount() , 1);
    }

    function test_DuplicateDonorDoesNotIncreaseCount() public {
        vm.startPrank(donor1);
        tracker.donate{value : 1 ether}();
        tracker.donate{value : 1 ether}();
        vm.stopPrank();

        assertEq(tracker.donations(donor1) , 2 ether);
        assertEq(tracker.getDonorsCount(), 1 );
    }

    function test_MultipleDonrs() public {
        vm.prank(donor1);
        tracker.donate{value : 1 ether}();

        vm.prank(donor2);
        tracker.donate{value : 1 ether}();

        assertEq(tracker.getDonorsCount(),2);
        assertEq(tracker.totalDonations(),2 ether);
    }

    function test_Fail_DonateZero() public {
        vm.prank(donor1);
        vm.expectRevert("Donation must be greater than 0");
        tracker.donate{value : 0}();
    }

}