# 🎁 Donation Tracker

A decentralized donation tracking system built with **Solidity**. It records individual donations and maintains an aggregate total, while keeping an indexed list of unique donors.

## ✨ Key Features
- **Aggregate Tracking**: Tracks the total volume of donations received by the contract.
- **Unique Donor Indexing**: Uses an array to track distinct donors without duplicates.
- **Transparency**: Emits `DonationReceived` events for every transaction, ensuring a clear audit trail.

## 🚀 Usage
1. **Donate**: Users can send ETH to the `donate()` function.
   ```solidity
   donate{value: 1 ether}();