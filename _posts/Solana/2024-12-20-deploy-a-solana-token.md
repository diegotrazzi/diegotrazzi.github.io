---
layout: post
title: Deploy a Solana Token
categories: [Crypto]
tags: [Solana, crypto, cli]
date: 2024-12-20 21:36 +1300
---

# Deploy a Solana token on the testnet

* This will become a table of contents (this text will be scrapped).
{:toc}

### Set the Solana CLI to Use Testnet

> To ensure you’re interacting with the Solana testnet, run the following command
{: .prompt-tip}

```bash
solana config set --url https://api.testnet.solana.com
```

### Generate a New Wallet (if needed)

If you don’t already have a wallet, create one using the Solana CLI:

solana-keygen new --outfile ~/my-wallet.json

This generates a new wallet and saves it to the specified file. You can also use an existing wallet.

4. Fund Your Wallet (Testnet)

To deploy a token, you need some SOL to pay for transactions. You can request free SOL from the Solana testnet faucet:

solana airdrop 2

This will send 2 SOL to your wallet for use on the testnet.

5. Install the spl-token CLI

Solana uses the spl-token CLI to manage token creation. To install it, run:

cargo install spl-token-cli

6. Create the Token

To create a new token, run the following command:

spl-token create-token

This will output a token address (e.g., Token Address: <your-token-address>), which uniquely identifies your token.

7. Create a Token Account

Create an account to hold the token:

spl-token create-account <your-token-address>

8. Mint Tokens

To mint a certain amount of tokens to your newly created account, run:

spl-token mint <your-token-address> <amount> <your-token-account-address>

For example, to mint 1000 tokens:

spl-token mint <your-token-address> 1000 <your-token-account-address>

9. Verify Token Creation

You can verify the token creation and balance by running:

spl-token accounts

This will show your token balances.

10. Optional: Set Up Token Metadata (e.g., name, symbol)

You may want to set up token metadata using the metaplex CLI. Follow the steps in the Metaplex documentation to set metadata like name, symbol, and logo.

11. Check Token on Testnet

Once the token is minted, you can interact with it like any other Solana token. You can also view your testnet tokens using a Solana wallet like Phantom or Sollet.

Summary
	1.	Install Solana CLI and set the URL to Testnet.
	2.	Create a wallet and fund it with testnet SOL.
	3.	Use spl-token to create a token and mint it.
	4.	Verify the token and optionally add metadata.

Your new token is now deployed on the Solana testnet!

### References:
* [Install Solana Cli](https://solana.com/docs/intro/installation)