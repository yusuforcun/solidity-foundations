// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/forge-std/src/Test.sol";
import "../src/Faucet/Faucet.sol";

contract FaucetTest is Test {
    Faucet faucet;
    address alice = address(0x1337);

    function setUp() public {
        faucet = new Faucet();
        vm.deal(address(faucet), 1 ether);
        vm.deal(alice, 1 ether);
        // Zamanı en başa al, temiz başlangıç
        vm.warp(1000); 
    }

    function testWithdrawSuccess() public {
        // İlk çekimi yapabilmek için zamanı en az 1 gün ileri al
        vm.warp(2 days); 
        
        vm.prank(alice);
        uint256 beforeBalance = alice.balance;
        faucet.withdraw();
        
        assertEq(alice.balance, beforeBalance + 0.01 ether);
    }

    function testCooldownBlocksImmediateSecondWithdraw() public {
        vm.warp(2 days); // İlk çekim için uygun zaman
        vm.startPrank(alice);
        
        faucet.withdraw(); // İlk çekim başarılı
        
        // Hemen ikinciyi dene (Hata bekliyoruz)
        vm.expectRevert("Cooldown active");
        faucet.withdraw();
        
        vm.stopPrank();
    }

    function testCooldownAllowsAfterTimePasses() public {
        vm.warp(2 days); // İlk çekim
        vm.startPrank(alice);
        faucet.withdraw();

        // 1 gün 1 saniye daha geçsin
        vm.warp(block.timestamp + 1 days + 1);

        faucet.withdraw(); // Bu çalışmalı
        vm.stopPrank();
    }

    function testInsufficientBalanceReverts() public {
        Faucet emptyFaucet = new Faucet();
        vm.warp(2 days); // Cooldown'ı aş
        
        vm.prank(alice);
        vm.expectRevert("Insufficient faucet balance");
        emptyFaucet.withdraw();
    }
}