    # 💸 Tip Jar

A decentralized tipping contract. Users can send ETH tips to any address with a custom message. The contract tracks and stores statistics (total received, tip count) for every recipient.

## ✨ Key Features
- **Direct Payouts**: Tips go straight to the recipient's wallet.
- **Message Support**: Add a personalized note to your tip.
- **Stats Tracking**: Publicly verifiable statistics for every address that receives a tip.

## 🚀 Usage
1. **Send a Tip**: 
   ```solidity
   tip(0xRecipientAddress, "Thanks for the great content!") {value: 0.1 ether};