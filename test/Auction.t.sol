// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Auction/Auction.sol"; 

contract AuctionTest is Test {
    Auction auction ;
    address beneficiary = address(0x132465);
    address bidder1 = address(0x1);
    address bidder2 = address(0x2);


    function setUp() public {
        auction = new Auction(3600, beneficiary); // 1 hour duration
    }

    function test_BidUpdateHighestBid() public {
        vm.deal(bidder1 , 1 ether);
        vm.prank(bidder1);

        auction.bid{value : 0.5 ether}();

        assertEq(auction.highestBid(),0.5 ether);
        assertEq(auction.highestBidder() , bidder1);
    }

    function test_OutbidRevertsFundsToPending() public {
        vm.deal(bidder1,1 ether);
        vm.deal(bidder2,1 ether);

        vm.prank(bidder1);
        auction.bid{value : 0.1 ether}();

        vm.prank(bidder2);
        auction.bid{value: 0.2 ether}();

        assertEq(auction.highestBid() , 0.2 ether);
        assertEq(auction.pendingReturns(bidder1) , 0.1 ether);
    }

    function test_WithdrawalWorks() public {
        vm.deal(bidder1 , 1 ether );
        vm.prank(bidder1);
        auction.bid{value : 0.1 ether}();

        vm.deal(bidder2, 1 ether);
        vm.prank(bidder2);
        auction.bid{value : 0.2 ether}();

        uint256 balanceBefore = bidder1.balance;

        vm.prank(bidder1);
        auction.withdraw();

        assertEq(bidder1.balance , balanceBefore + 0.1 ether);
    }

    function test_EndAuction() public {
        vm.deal(bidder1 , 1 ether);
        vm.prank(bidder1);
        auction.bid{value : 0.5 ether}();

        vm.warp(block.timestamp + 3601); 

        auction.EndAuction();

        assertTrue(auction.ended());
        assertEq(beneficiary.balance , 0.5 ether);
    }
    
    receive() external payable {}

}