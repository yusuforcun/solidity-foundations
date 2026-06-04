# 🏦 Deposit Vault

A secure, flexible ETH vault contract built with **Solidity**. This contract allows users to deposit Ether and withdraw their funds partially or fully at any time, maintaining individual balance records.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

---

## 📖 Overview

The Deposit Vault serves as a personal "savings account" on the blockchain. It utilizes a `mapping` to track each user's balance independently. The contract follows the **Checks-Effects-Interactions (CEI)** pattern to ensure secure and gas-efficient withdrawals.

## ✨ Key Features

- **Flexible Deposits**: Users can deposit ETH multiple times to build their balance.
- **Partial Withdrawals**: Unlike time-locked wallets, users can withdraw any amount up to their total balance.
- **Re-entrancy Protection**: Implements the CEI pattern, updating internal balances before interacting with external addresses.
- **Event Logging**: Emits `Deposited` and `Withdrawn` events, allowing for easy tracking on block explorers.

## 🚀 Usage

### 1. Deposit
Send ETH to the vault to increase your balance:
```solidity
deposit{value: 1 ether}();