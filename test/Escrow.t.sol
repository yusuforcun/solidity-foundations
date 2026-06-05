// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Escrow/Escrow.sol"; 

contract EscrowTest is Test{
    Escrow escrow ;
    address depositor = address(0x1);
    address beneficiary = address(0x2);
    address arbiter = address(0x3);
    address stranger = address(0x4);

    function setUp() public {
        vm.prank(depositor);
        escrow = new Escrow(arbiter , beneficiary);
    }

    function test_DepositAndApprove() public {
        vm.deal(depositor , 1 ether);
        vm.prank(depositor);
        payable(address(escrow)).transfer(1 ether);

        assertEq(address(escrow).balance, 1 ether);

        vm.prank(arbiter);
        escrow.approve();

        assertTrue(escrow.isApproved());
    }

    function test_Withdrawal() public {
        vm.deal(depositor , 1 ether );
        vm.prank(depositor);
        payable(address(escrow)).transfer(1 ether);
    
        vm.prank(arbiter);
        escrow.approve();

        uint256 balanceBefore = beneficiary.balance;

        vm.prank(beneficiary);
        escrow.withdraw();

        assertEq(beneficiary.balance , balanceBefore + 1 ether);
        assertEq(address(escrow).balance , 0 );
    }

    function test_Fail_UnauthorizedApproval() public {
        vm.prank(stranger);
        vm.expectRevert("Only arbiter can approve");
        escrow.approve();
    }

    function test_Fail_UnauthorizedWithdrawal() public {
        vm.prank(arbiter);
        escrow.approve();

        vm.prank(stranger);
        vm.expectRevert("Only beneficiary can withdraw");
        escrow.withdraw();
    }


}

