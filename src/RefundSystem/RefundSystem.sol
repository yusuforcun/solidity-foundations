//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RefundSystem{
    
    uint256 public goal ;
    uint256 public deadline ;
    uint256 public totalRaised ;

    enum State{ Active, Success , Refundable }
    State public currentState = State.Active ;

    mapping(address => uint256) public contributions ;

    event Contributed(address indexed user , uint256 amount);
    event Refunded(address indexed user , uint256 amount);

    constructor(uint256 _goal , uint256 _duration){
        goal = _goal ;
        deadline = block.timestamp + _duration ;
    }

    function contribute() external payable{
        require(currentState == State.Active , "Not active");
        require(block.timestamp < deadline , "Deadline passed");

        contributions[msg.sender] += msg.value ;
        totalRaised += msg.value ;

        emit Contributed(msg.sender , msg.value);
    }

    function checkState() external {
        if(block.timestamp >= deadline){
            if(totalRaised >= goal){
                currentState = State.Success ;
            } else {
                currentState = State.Refundable ;
            }
        }
    }

    function refund() external {
        require(currentState == State.Refundable ,"Not refundable");
        uint256 amount = contributions[msg.sender] ;
        require(amount > 0 ,"No contributions");

        contributions[msg.sender] = 0 ;
        (bool success ,) = payable(msg.sender).call{value : amount}("");
        require(success , "Refund failed");

        emit Refunded(msg.sender , amount);
    }
 }