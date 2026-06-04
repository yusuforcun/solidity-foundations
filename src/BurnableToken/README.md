# 🔥 Burnable Token Logic

A simple implementation of a burnable token system. This contract demonstrates how to manage total token supply and individual balances securely while providing a mechanism to permanently remove tokens from circulation.

## 📖 Overview
Burning tokens reduces the `totalSupply`. This is a common mechanism in DeFi to control inflation or increase the scarcity of an asset.

## ✨ Key Features
- **Total Supply Tracking**: Accurately tracks the active circulating supply.
- **Burn Mechanism**: Allows token holders to reduce their own balance and the total supply simultaneously.
- **Security**: Ensures users cannot burn more tokens than they possess and prevents burning zero-value amounts.

## 🚀 Usage
1. **Mint**: Create tokens to an address (e.g., `mint(address, 1000)`).
2. **Burn**: Reduce your own token balance:
   ```solidity
   burn(100);