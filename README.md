# Base Token

A simple ERC20 token implementation built with Foundry for educational purposes, using OpenZeppelin's secure and battle-tested smart contract libraries.

## Overview

Base Token demonstrates basic smart contract development patterns:

- **ERC20 Standard**: Standard token functionality (transfer, approve, allowance)
- **Access Control**: Owner-only minting using OpenZeppelin's AccessControl
- **Testing**: Complete test suite using Forge
- **Security**: Built with OpenZeppelin contracts for maximum security

## Token Details

- **Name**: Base
- **Symbol**: BASE
- **Initial Supply**: 1,000 tokens
- **Decimals**: 18

## Getting Started

### Prerequisites
- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed

### Installation
```bash
git clone <repository-url>
cd based-token
forge install
forge build
```

### Testing
```bash
forge test
```

### Deployment
```bash
forge script script/BaseToken.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

## Key Functions

- `mint(address to, uint256 amount)` - Mint tokens (owner only)
- Standard ERC20 functions: `transfer`, `approve`, `transferFrom`
- `hasRole(bytes32 role, address account)` - Check permissions

## Security Notice

⚠️ **Educational project only** - Not for production use without proper security audits.
