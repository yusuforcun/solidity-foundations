//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoleBasedAccess{

    mapping(address => bool) public admins ;

    event AdminGranted(address indexed account);
    event AdminRevoked(address indexed account);

    address public owner ;

    constructor(){
        owner=msg.sender ;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier onlyAdmin(){
        require(msg.sender == owner  || admins[msg.sender] , "Not an admin");
        _;
    }

    function grantRole(address _admin) external onlyOwner {
        require(_admin != address(0),"Invalid address");
        admins[_admin] = true ;
        emit AdminGranted(_admin);
    }

    function revokeRole(address _admin) external onlyOwner {
        admins[_admin] = false ;
        emit AdminRevoked(_admin);
    }

    function restrictedAction() external onlyAdmin{

    }


}