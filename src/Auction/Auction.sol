// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Auction {
    
    address public beneficiary ;
    uint256 public auctionEndTime ;
    address public highestBidder ;
    uint256 public highestBid ;
    bool public ended ;

    mapping(address => uint256) public pendingReturns ;

    event HighestBidIncreased(address indexed bidder , uint256 amount);
    event AuctionEnded(address winner ,uint256 amount);

    constructor(uint256 _biddingTime , address _beneficiary) {
        beneficiary = _beneficiary ;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() external payable {
        require(block.timestamp < auctionEndTime , "Auction ended") ;
        require(msg.value > highestBid , "Bid too low");

        if(highestBid != 0){
            pendingReturns[highestBidder] += highestBid ;
        }

        highestBidder = msg.sender ;
        highestBid = msg.value ;
        emit HighestBidIncreased(msg.sender , msg.value);

    }

    function withdraw() external   returns (bool){
        uint256 amount = pendingReturns[msg.sender];

        if(amount > 0 ){
            pendingReturns[msg.sender] = 0 ;
            (bool success ,) = msg.sender.call{value:amount}("");
            if(!success){
                pendingReturns[msg.sender]=amount ;
                return false ;
            }
        }
        return true ;
    }

    function EndAuction() external {
        require(block.timestamp >= auctionEndTime , "Auction not ended yet");
        require(!ended , "Already ended");
        ended = true ;
        emit AuctionEnded((highestBidder), highestBid);
        (bool success , ) = beneficiary.call{value:highestBid} ("");
        require(success , "Transfer to beneficiary failed");
    }
}