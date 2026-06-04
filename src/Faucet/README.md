# 💧 Faucet Smart Contract

A robust, secure, and gas-efficient Faucet implementation built with **Solidity** and tested using the **Foundry** framework. This project demonstrates core smart contract concepts, including cooldown mechanisms, access control, and secure token/Ether transfers.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Foundry](https://img.shields.io/badge/Built_with-Foundry-FF3E3E.svg)](https://getfoundry.sh/)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

---

## 📖 Overview

The Faucet contract allows users to withdraw a fixed amount of Ether. To prevent abuse and spam, the contract enforces a cooldown period for each address. This implementation is designed to teach best practices in smart contract development, including:

- **Security**: Preventing re-entrancy and handling state safely.
- **Gas Efficiency**: Optimized state variable access and transfer methods.
- **Testing**: Using Foundry to simulate various scenarios like cooldowns and insufficient balances.

## ✨ Key Features

- **Withdrawal Limits**: Set a fixed `WITHDRAW_AMOUNT` to ensure fair distribution.
- **Cooldown Mechanism**: Restricts users to one withdrawal per set duration (e.g., 24 hours).
- **Balance Protection**: Prevents withdrawals if the contract balance is insufficient.
- **Robust Testing**: 100% coverage on core logic using Foundry's `forge test` suite.

## 🚀 Getting Started

### Prerequisites

You must have [Foundry](https://getfoundry.sh/) installed on your machine.

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/solidity-foundations.git](https://github.com/your-username/solidity-foundations.git)
   cd solidity-foundations