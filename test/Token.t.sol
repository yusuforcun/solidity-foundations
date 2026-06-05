// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Token/Token.sol";

contract TokenTest is Test {
    Token token;
    address owner = address(this);
    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        token = new Token();
    }

    function test_Mint() public {
        token.mint(user1, 1000);
        assertEq(token.balances(user1), 1000);
    }

    function test_Transfer() public {
        token.mint(user1, 1000);
        
        vm.prank(user1);
        token.transfer(user2, 400);

        assertEq(token.balances(user1), 600);
        assertEq(token.balances(user2), 400);
    }

    function test_Fail_InsufficientBalance() public {
        token.mint(user1, 100);

        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        token.transfer(user2, 101);
    }

    function test_Fail_ZeroAddressTransfer() public {
        token.mint(user1, 100);
        
        vm.prank(user1);
        vm.expectRevert("Invalid recipient address");
        token.transfer(address(0), 10);
    }
}