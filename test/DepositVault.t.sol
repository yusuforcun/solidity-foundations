// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/DepositVault/DepositVault.sol";

contract DepositVaultTest is Test {
    DepositVault vault ;
    address user = address(0x1);

    function setUp() public {
        vault = new DepositVault();
        vm.deal(user , 10 ether);
    }

    function test_Deposit() public {
        vm.prank(user);
        vault.deposit{value : 1 ether}() ;

        assertEq(vault.balances(user),1 ether);
        assertEq(address(vault).balance , 1 ether);
    }

    function test_Withdraw() public {
        vm.prank(user);
        vault.deposit{value : 1 ether}();

        uint256 balanceBefore = user.balance ;

        vm.prank(user);
        vault.withdraw(0.5 ether);

        assertEq(vault.balances(user) , 0.5 ether);
        assertEq(user.balance , balanceBefore + 0.5 ether);
    }

    function test_Fail_WithdrawInsufficientFunds() public {
        vm.prank(user);
        vault.deposit{value:0.5 ether}();

        vm.prank(user);
        vm.expectRevert("Insufficient funds");
        vault.withdraw(1 ether);
    }

    function test_Fail_DepositZero() public {
        vm.prank(user);
        vm.expectRevert("Deposit amount must be greater than zero");
        vault.deposit{value : 0}();
    }

    function test_MultipleDeposits() public {
        vm.startPrank(user);

        vault.deposit{value : 1 ether}();
        vault.deposit{value : 0.5 ether}();
        vault.deposit{value : 0.25 ether}();

        vm.stopPrank();

        assertEq(vault.balances(user), 1.75 ether);
    }

    function test_FullWithDraw() public {
        vm.prank(user);
        vault.deposit{value : 1 ether}();

        vm.prank(user);
        vault.withdraw(1 ether);

        assertEq(vault.balances(user),0);
        assertEq(address(vault).balance,0);
    }

    function test_FailedWithdraw_DoesNotChangeState() public {
        vm.prank(user);
        vault.deposit{value : 0.5 ether}();

        vm.prank(user);
        vm.expectRevert("Insufficient funds");
        vault.withdraw(1 ether);

        assertEq(vault.balances(user) , 0.5 ether);
    }

}