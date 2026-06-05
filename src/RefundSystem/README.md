    # 📉 Refund System

A crowdfunding-style contract implementing an "All-or-Nothing" funding logic. Funds are collected until a deadline. If the goal is not met, the contract enters a `Refundable` state, allowing contributors to reclaim their funds.

## ✨ Key Features
- **State Machine**: Uses `enum` to transition between `Active`, `Success`, and `Refundable`.
- **Pull-Payment**: Secure refund mechanism prevents gas limit issues for large contribution counts.
- **Goal Verification**: Explicitly tracks `totalRaised` against a defined `goal`.

## 🚀 Usage
1. **Contribute**: Users send ETH during the active period.
2. **Check Status**: After the deadline, anyone can call `checkState()` to update the contract's state.
3. **Refund**: If the goal failed, contributors call `refund()` to get their ETH back.