# 🛡️ Allowlist System

A simple yet effective access control system in **Solidity**. This contract restricts the execution of specific functions to a pre-approved list of addresses managed by the contract owner.

## ✨ Key Features
- **Owner-Only Management**: Only the contract owner can add or remove addresses from the allowlist.
- **Modifier Protection**: Uses the `onlyAllowed` modifier for clean and reusable access control.
- **Transparency**: Emits events whenever an address is added or removed from the list.

## 🚀 Usage
1. **Add Address**: The owner adds an address:
   ```solidity
   addToAllowList(0x123...);