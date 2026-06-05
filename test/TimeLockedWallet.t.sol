// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/TimeLockedWallet/TimeLockedWallet.sol";

contract TimeLockedWalletTest is Test {
    TimeLockedWallet wallet;
    address user = address(0x1);

    function setUp() public {
        wallet = new TimeLockedWallet();
        vm.deal(user, 10 ether);
    }

    function test_DepositAndWithdraw() public {
        vm.startPrank(user);
        
        // 1. Yatırma işlemi (1 gün kilitli)
        wallet.deposit{value: 1 ether}(1 days);
        
        // 2. Kilidin açılmasını bekle (Zamanı ileri sar)
        vm.warp(block.timestamp + 1 days + 1);
        
        // 3. Para çekme
        uint256 balanceBefore = user.balance;
        wallet.withdraw();
        
        assertEq(user.balance, balanceBefore + 1 ether);
        vm.stopPrank();
    }

    function test_Fail_WithdrawTooEarly() public {
        vm.startPrank(user);
        wallet.deposit{value: 1 ether}(1 days);
        
        // Zamanı azıcık ilerlet ama gün dolmasın
        vm.warp(block.timestamp + 10 hours);
        
        vm.expectRevert("Funds are still locked");
        wallet.withdraw();
        vm.stopPrank();
    }

    function test_Fail_MultipleDeposits() public {
        vm.startPrank(user);
        wallet.deposit{value: 1 ether}(1 days);
        
        // İkinci kez deposit etmeye çalışma
        vm.expectRevert("Existing deposit found.");
        wallet.deposit{value: 0.5 ether}(1 days);
        vm.stopPrank();
    }
}