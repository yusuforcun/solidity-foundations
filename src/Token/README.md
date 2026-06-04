# 🪙 Minimal Token Ledger

A lightweight, custom token system implemented in **Solidity**. This contract demonstrates the core mechanics of a digital token, including minting, internal ledger management, and secure value transfers.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

---

## 📖 Overview

The Token contract manages a balance ledger using mappings. Unlike the ERC-20 standard, this implementation is stripped-down to its simplest form to highlight the essential logic of token movement on the blockchain.

## ✨ Key Features

- **Balance Ledger**: Uses a `mapping(address => uint256)` to track ownership.
- **Minting Mechanism**: Allows the creation of new tokens, emitting a `Transfer` event from the null address (`0x0`).
- **Secure Transfers**: Ensures safety by verifying recipient address validity and sender balance.
- **Event-Driven**: Emits `Transfer` events for every movement of tokens, ensuring transparency for off-chain observers.

## 🚀 Usage

### 1. Minting Tokens
Create new tokens and assign them to an address:
```solidity
mint(recipient_address, 1000);