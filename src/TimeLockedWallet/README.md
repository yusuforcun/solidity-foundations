# 🔒 Time-Locked Wallet

A secure, time-locked storage contract for Ether. This contract allows users to deposit funds with a specific unlocking duration, preventing withdrawal until the time limit has expired.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

## 📖 Overview

The Time-Locked Wallet is designed for users who want to secure their funds for a specific period. Once deposited, the Ether is locked within the contract and cannot be withdrawn until the `unlockTime` (current time + duration) has passed.

## ✨ Key Features

- **Duration-Based Locking**: Users define exactly how long they want their funds to be locked during the deposit.
- **Single-Deposit Security**: To keep state management clean, each address can only hold one active deposit at a time.
- **Secure Withdrawal Pattern**: Implements the "Checks-Effects-Interactions" pattern, ensuring state is cleared before funds are transferred.
- **Gas-Efficient**: Minimal storage usage for maximum security.

## 🚀 Usage

### Depositing Funds
Call the `deposit` function with the desired duration in seconds:
```solidity
// Deposit 1 ETH for 1 day (86400 seconds)
deposit(86400){value: 1 ether}