# 🔨 Simple Auction

A robust auction smart contract implemented in **Solidity**. It features a time-based mechanism, high-bid tracking, and a "Pull Payment" system for secure fund refunds.

## ✨ Key Features
- **Pull Payment Pattern**: Failed bidders can withdraw their funds safely, preventing the contract from locking up due to failed transfers.
- **State Machine**: Ensures the auction can only be ended once and only after the deadline.
- **Time-Locked**: Bidding is strictly limited by the `auctionEndTime`.

## 🚀 Usage
1. **Bid**: Call `bid()` with ETH. If you are outbid, your funds move to `pendingReturns`.
2. **Withdraw**: If you were outbid, call `withdraw()` to get your funds back.
3. **End**: Once the deadline passes, anyone can call `endAuction()` to transfer funds to the beneficiary.