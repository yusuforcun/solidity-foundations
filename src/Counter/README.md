# 🔢 Simple Counter Contract

A gas-efficient and secure Counter contract built with **Solidity**. This project demonstrates basic state management, arithmetic operations, and secure underflow prevention.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

## 📖 Overview

The Counter contract serves as a foundational example of smart contract state management. It allows users to increment and decrement a numeric counter while ensuring the value never drops below zero.

## ✨ Key Features

- **Increment Functionality**: Safely increases the counter using Solidity's built-in overflow protection.
- **Underflow Protection**: Explicitly checks that the counter value is greater than zero before allowing a decrement, preventing logic errors and providing a clear error message.
- **State Transparency**: The `count` variable is `public`, making it easily accessible for external applications and test suites.

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://getfoundry.sh/) installed on your system.

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/counter-contract.git](https://github.com/your-username/counter-contract.git)
   cd counter-contract