// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/BurnableToken/BurnableToken.sol";

contract BurnableTokenTest is Test {
    BurnableToken token;
    address user = address(0x1);
    address bob = address(0x2);

    function setUp() public {
        token = new BurnableToken();
        token.mint(user, 1000);
        token.mint(bob, 1000);
    }

    function testBurn() public {
        vm.prank(user);
        token.burn(500);

        assertEq(token.balances(user),500);
        assertEq(token.totalSupply(), 1500);
    }

    function test_Fail_BurnInsufficientBalance() public {
        vm.prank(user);
        vm.expectRevert("Insufficient balance");
        token.burn(2000) ;
    }

    function test_Fail_BurnZeroAmount() public {
        vm.prank(user);
        vm.expectRevert("Amount must be greater than zero");
        token.burn(0) ;
    }

    function test_BurnEmitEvent() public {
        vm.prank(user);

        vm.expectEmit(true , false , false , true);
        emit BurnableToken.Burn(user,100) ;
        token.burn(100);
    }

    function test_TotalBurned() public {
        vm.prank(user);
        token.burn(200);

        vm.prank(bob);
        token.burn(100);

        assertEq(token.totalBurned(), 300); 
    }

    function test_MultipleUsersBurn() public {
        token.mint(bob , 500) ;

        vm.prank(user);
        token.burn(300);

        vm.prank(bob);
        token.burn(200);

        assertEq(token.totalSupply(),2000);
    }

    function test_MintNotOwner() public {
        vm.prank(user);

        vm.expectRevert("Only owner can call this function");
        token.mint(user,100);
    }




}