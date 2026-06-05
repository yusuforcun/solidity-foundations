// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/RoleBasedAccess/RoleBasedAccess.sol";

contract RoleBasedAccessTest is Test {
    RoleBasedAccess rbac;
    address owner = address(this);
    address admin = address(0x1);
    address stranger = address(0x2);

    function setUp() public {
        rbac = new RoleBasedAccess();
    }

    function test_GrantAndRevokeRole() public {
        rbac.grantRole(admin);
        assertTrue(rbac.admins(admin));

        rbac.revokeRole(admin);
        assertFalse(rbac.admins(admin));
    }

    function test_OnlyAdminCanPerformAction() public {
        rbac.grantRole(admin);

        vm.prank(admin);
        rbac.restrictedAction();

        vm.prank(stranger);
        vm.expectRevert("Not an admin");
        rbac.restrictedAction();
    }

    function test_OwnerCanPerformAction() public {
        rbac.restrictedAction();
    }

    function test_Fail_NonOwnerGrantRole() public {
        vm.prank(stranger);
        vm.expectRevert(); 
        rbac.grantRole(admin);
    }
}