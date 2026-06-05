# 🛡️ Role-Based Access Control

A centralized-decentralized hybrid access control system.

## ✨ Key Features
- **Owner-Centric Management**: Only the owner can grant or revoke admin privileges.
- **Admin Access**: Admins are authorized to perform restricted actions, reducing the bottleneck on the owner.
- **Security**: Includes zero-address checks and robust modifier enforcement.

## 🚀 Usage
1. **Grant Admin**: Owner authorizes a new address.
   ```solidity
   grantRole(0xAddress);