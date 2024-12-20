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

## Set the Solana CLI to Use Testnet

> To ensure you’re interacting with the Solana testnet, run the following command
{: .prompt-tip}

```bash
solana config set --url https://api.devnet.solana.com --keypair ~/my-devnet-wallet.json
```

## Generate a New Wallet (if needed)

If you don’t already have a wallet, create one using the Solana CLI:

```bash
solana-keygen grind --starts-with com:1
```

Grind will search for an address that starts with the prefix ("com" in this case).
If you just want to have a key pair you can also use:

```bash
solana-keygen new --outfile ~/compute-coin--devnet-wallet.json
```

This generates a new wallet and saves it to the specified file. You can also use an existing wallet.

## Fund Your Wallet (Devnet)

Set the solana configuration so that it know which wallet to use:

```bash
solana config set --keypair ~/path_to_your_wallet.json
```

To deploy a token, you need some SOL to pay for transactions. You can request free SOL from the Solana devnet faucet:

```bash
solana airdrop 2
```

This will send 2 SOL to your wallet for use on the devnet.
You can check the wallet balance with:

```bash
solana balance
```

Alternatively use this website: [Solana faucet](https://faucet.solana.com/)

## Install the spl-token CLI

Solana uses the spl-token CLI to manage token creation. To install it, run:

```bash
cargo install spl-token-cli
```

## Create the Token

To create a new token, run the following command:

```bash
spl-token create-token
```
```bash
Creating token 6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42 under program TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA

Address:  6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42
Decimals:  9

Signature: 3mQMi7cjYHqKvy1RohBJwaMJu4qTnVWbPQq5tvEW2KrTGMx1S1WHwAnNJrRKqM7m25URGvPSgGUSXr21DaY5QRn3
```

This will output a token address (e.g., Token Address: <your-token-address>), which uniquely identifies your token.

You can check the token details on [explorer.solan.com](https://explorer.solana.com/?cluster=devnet)

## Create a Token Account

Create an account to hold the token:

```bash
spl-token create-account <your-token-address>
```

```bash
spl-token create-account 6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42
```

## Mint Tokens

To mint a certain amount of tokens to your newly created account, run:

```bash
spl-token mint <your-token-address> <amount> <your-token-account-address>
```

For example, to mint 1B tokens:

```bash
pl-token mint 6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42 1000000000 CzBCZTAe9EKEcDknDtBjFw6dpGRUVv9DHEvwhjNqXQst                                            
Minting 1000000000 tokens
  Token: 6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42
  Recipient: CzBCZTAe9EKEcDknDtBjFw6dpGRUVv9DHEvwhjNqXQst

Signature: 3UWKR6erR6kZ497CBHw48SNE8ERjppfAJrSCuGgA4kY4HczdG4iAftXTFpFV9DbMxxMckU7X8Y4VZYR2nkugAzwt
```

## Verify Token Creation

You can verify the token creation and balance by running:

```bash
spl-token accounts
Token                                         Balance   
--------------------------------------------------------
6UcyYdRh1EC3Xzbufw7gSMvvKXQRnUjm6C72QdSx6M42  1000000000
```

This will show your token balances.

## Optional: Set Up Token Metadata (e.g., name, symbol)

You may want to set up token metadata using the `metaplex` CLI. Follow the steps in the Metaplex documentation to set metadata like name, symbol, and logo.

To set up and use Metaplex on macOS, you will need to install the Metaplex CLI and configure it properly to interact with the Solana blockchain for tasks like adding metadata to your tokens or creating NFTs. Below is the detailed guide to get started:

```bash
brew install node
```

Verify installation: 

```bash
node -v
npm -v
```

Install  Metaplex:

```bash
npm install @solana/web3.js @metaplex-foundation/js
```


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
* [How to create a token](https://solana.com/developers/guides/getstarted/how-to-create-a-token)
* [How to use transfer fee extension](https://solana.com/developers/guides/token-extensions/transfer-fee)
