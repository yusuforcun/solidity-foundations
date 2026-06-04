# 🛡️ Simple Escrow System

A secure, trustless Escrow smart contract built with **Solidity**. This contract facilitates transactions between two parties (Depositor and Beneficiary) by requiring approval from a trusted third party (Arbiter).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

---

## 📖 Overview

The Escrow contract serves as a middleman to ensure fair trade. 
1. **Depositor** sends funds to the contract.
2. **Arbiter** validates that the transaction conditions are met and calls `approve()`.
3. **Beneficiary** withdraws the funds after the arbiter's approval.

## ✨ Key Features

- **Trustless Execution**: Neither the depositor nor the beneficiary can manipulate the funds without the arbiter's sign-off.
- **Role-Based Access**: Strict `require` statements ensure only the authorized `arbiter` can approve and only the `beneficiary` can withdraw.
- **Secure Transfers**: Uses the `.call()` method for gas-safe transfers, protecting against transfer-related failures.
- **State Integrity**: Implements the "Checks-Effects" pattern to prevent re-entrancy and double-spending.

## 🚀 Usage

### 1. Deployment
Deploy the contract by passing the `arbiter` address and `beneficiary` address to the constructor.

### 2. Deposit
The `depositor` can send Ether directly to the contract address. The `receive()` function will automatically accept the funds.

### 3. Approve
The `arbiter` calls the `approve()` function once the trade conditions are satisfied:
```solidity
approve();