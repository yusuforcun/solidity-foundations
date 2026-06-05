# 🎰 Simple Lottery Contract

A decentralized lottery system where participants contribute ETH to a prize pool, and a winner is chosen pseudo-randomly.

## ✨ Key Features
- **Entry Requirement**: Enforces a minimum entry fee (0.01 ETH).
- **Pseudo-Random Selection**: Utilizes `block.prevrandao` for selecting a winner from the participant pool.
- **Auto-Reset**: The player list is automatically cleared after a winner is paid, preparing the contract for the next round.
- **Transparency**: Emits events for both entries and winner selection.

## 🚀 Usage
1. **Enter**: Users call `enter()` with at least 0.01 ETH.
2. **Pick Winner**: The manager calls `pickWinner()` to randomly select and pay the winner.