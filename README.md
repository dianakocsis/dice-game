# Dice Game

## Description

Dice Game is a contract that allows users to roll the dice to try and win the prize. If players roll either a 0, 1, 2, 3, 4 or 5 they will win the current prize amount. The initial prize is 10% of the contract's balance, which starts out at .05 Eth.

Every time a player rolls the dice, they are required to send .002 Eth. 40 percent of this value is added to the current prize amount while the other 60 percent stays in the contract to fund future prizes. Once a prize is won, the new prize amount is set to 10% of the total balance of the DiceGame contract.

RiggedRoll attacks the Dice Game contract! It predicts the randomness ahead of time and only rolls the dice when you're guaranteed to be a winner.

## Installation and Setup Instructions

### Prerequisites

- Node (v18 LTS)
- Yarn (v1 or v2+)
- Git

### Clone the Repository

To get started, clone the repository to your local machine:

```bash
git clone https://github.com/dianakocsis/dice-game
```

### Environment Setup

1. Navigate to the cloned directory:

   ```bash
   cd dice-game
   ```

2. Copy the .env.example files to create a new .env file and fill in the necessary details:

   ```bash
   cp .env.example .env
   ```

   ```bash
   cd frontend
   cp .env.example .env
   ```

### Environment Setup

1. Install Dependencies

   To install project dependencies, run the following commands:

   ```bash
   yarn install
   cd frontend && yarn install
   cd ..
   ```

2. Start Local Blockchain

   In a new terminal, start the local blockchain:

   ```bash
   yarn chain
   ```

3. Deploy Contracts (In another tab)

   Open another terminal tab and deploy the contracts:

   ```bash
   yarn deploy
   ```

4. Start the Aplication (In another tab)

   Finally, in a new terminal tab, start the application:

   ```bash
   yarn start
   ```

## Testnet Deploy Information

| Contract   | Address Etherscan Link                                                            |
| ---------- | --------------------------------------------------------------------------------- |
| DiceGame   | `https://sepolia.etherscan.io/address/0xB84CA7DAD1a70f85Dd56026AE1A5e7d269BB7b1C` |
| RiggedRoll | `https://sepolia.etherscan.io/address/0x6AC3922F48d2Ab18EfCb6F2fb9BE68f16E8Cc4f9` |
