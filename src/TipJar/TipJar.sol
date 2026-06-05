//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {

    event TipReceived(address indexed from , uint256 amount , string message) ;

    struct TipperData{
        uint256 totalReceived;
        uint256 tipCount;
    }


    mapping(address => TipperData) public tips ;

    function tip(address _to,string memory _message) public payable{
        require(msg.value >0,"Tip amount must be greater than zero") ;
        (bool success , ) = _to.call{value:msg.value}("");
        require(success,"Failed to receive tip") ;
        tips[_to].totalReceived += msg.value ;
        tips[_to].tipCount += 1 ;
        emit TipReceived(msg.sender,msg.value,_message);
    }

    function getTotalReceived() public view returns(uint256){
        return tips[msg.sender].totalReceived ;
    }

    function getTipperStats(address _user) external view returns(uint256,uint256){
        return (tips[_user].totalReceived , tips[_user].tipCount);
    }
    
}