# 🗳️ Simple Voting System

A decentralized "Yes/No" voting system implemented in **Solidity**. This contract ensures data integrity by allowing each address to cast only one vote, preventing duplicate entries.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.20-blue.svg)](https://soliditylang.org/)

## 📖 Overview

The Voting contract provides a straightforward mechanism for polls where users can choose between two options ("Yes" or "No"). The system enforces a strict **one-vote-per-address** policy, leveraging Solidity mappings to track participation and prevent ballot stuffing.

## ✨ Key Features

- **Single Vote Enforcement**: Utilizes a `mapping(address => bool)` to ensure each user can only vote once.
- **Gas-Efficient State Management**: Uses modern Solidity `++` operators for counting.
- **Robust Security**: Employs the "Checks-Effects" pattern to ensure that the user's vote status is verified before any state changes occur.

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://getfoundry.sh/) installed.

### Installation

1. **Clone the repository:**
```bash
   git clone [https://github.com/your-username/voting-system.git](https://github.com/your-username/voting-system.git)
   cd voting-system