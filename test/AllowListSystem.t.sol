// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/AllowListSystem/AllowListSystem.sol"; 

contract AllowListSystemTest is Test {
  AllowListSystem allowList ;
  address owner = address(this);
  address user = address(0x1);
  address user2 = address(0x3);
  address attacker = address(0x2);

  function setUp() public {
    allowList = new AllowListSystem();
  }

  function test_GrantAccess() public {
    allowList.addToAllowList(user);
    assertTrue(allowList.isAllowed(user));
  }

  function test_Fail_NonOwnerGrantsAccess() public {
    vm.prank(attacker);
    vm.expectRevert("Only owner can add to allowlist");
    allowList.addToAllowList(user);
  }

  function test_RestrictedFunctionAccess() public {
    allowList.addToAllowList(user);

    vm.prank(user);
    allowList.restrictedFunction();
  }

  function test_Fail_UnauthorizedAccess() public {
    vm.prank(attacker);
    vm.expectRevert("Not allowed");
    allowList.restrictedFunction();
  }

  function test_RevokeAccess() public {
    allowList.addToAllowList(user);
    allowList.removeFromAllowList(user);

    assertFalse(allowList.isAllowed(user));

    vm.prank(user);
    vm.expectRevert("Not allowed");
    allowList.restrictedFunction();
  }

  function test_Revert_AddZeroAddress() public {
    vm.expectRevert();
    allowList.addToAllowList(address(0));
  }

  function test_Revert_RemoveNonExistingUser() public {
    vm.expectRevert();
    allowList.removeFromAllowList(user);
  }

  function test_DuplicateAddDoesNotBreakState() public {
    allowList.addToAllowList(user);
    allowList.addToAllowList(user);

    assertTrue(allowList.isAllowed(user));
  }

  function test_EventsEmittedCorrectly() public {
    vm.expectEmit(true , false , false , true);
    emit AllowListSystem.AddedToAllowList(user);

    allowList.addToAllowList(user);

    vm.expectEmit(true , false , false , true);
    emit AllowListSystem.RemovedFromAllowList(user);

    allowList.removeFromAllowList(user);
  }

  function test_MultipleUserIsolation() public {
    allowList.addToAllowList(user);
    allowList.addToAllowList(user2);

    allowList.removeFromAllowList(user);

    assertFalse(allowList.isAllowed(user));
    assertTrue(allowList.isAllowed(user2));
  }
    
}