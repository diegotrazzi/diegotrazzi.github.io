---
layout: post
title: Deploy a Solana Token
categories: [Crypto]
tags: [Solana, crypto, cli]
date: 2024-12-20 21:36 +1300
---

* This will become a table of contents (this text will be scrapped).
{:toc}

## Deploy a Solana token on the devnet - Final Result

![Phantom DevNet Balance](/assets/Solana/DevNetBalance.png){: .left width="300"}

## Set Solana CLI to Use Testnet

After installing Solana cli discussed in the previous article, create a folder to store the new token details and set the solana config to devnet

> To ensure you’re interacting with the Solana devnet, run the following command
{: .prompt-tip}

```bash
solana config set --url devnet
```

## Generate a New Wallet (if needed)

If you don’t already have a wallet, create one using the Solana CLI:

```bash
solana-keygen grind --starts-with cc:1
```

Grind will search for an address that starts with the prefix ("com" in this case).
If you just want to have a key pair you can also use:

```bash
solana-keygen new --outfile ~/compute-coin--devnet-wallet.json
```

This generates a new wallet and saves it to the specified file. You can also use an existing wallet.

Configure Solana CLI to use the keypair we just created 

```bash
solana config set --keypair ~/path_to_your_wallet.json
```

Double check the configuration is running correctly with:

```bash
solana config get
```

## Request Faucet Airdrop to fund the wallet (Devnet)

For Solana devnet we use free SOL through the DevNet [Solana faucet](https://faucet.solana.com/).

The CLI didn't seem to work for me, but alternately you can use: 

```bash
solana airdrop 5
```

This will send 5 SOL to your wallet for use on the devnet.

You can check the wallet balance with:

```bash
solana balance
```

## Install the spl-token CLI

Solana uses the spl-token CLI to manage token creation. If needed, install it by running:

```bash
cargo install spl-token-cli
```

## Create a Mint Address

Let's create one more address that we will use for our Mint Account - the factory that makes our specific token. We'll make it start with mnt to help us remember it's the token mint account.

```bash
solana-keygen grind --starts-with mnt:1
```

## Create the token mint account

Now, we will create the token mint, specifying to use the Token Extensions Program `TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb`, with the metadata extension enabled.

```bash
spl-token create-token --program-id TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb --enable-metadata mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k.json

Creating token mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k under program TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb
To initialize metadata inside the mint, please run `spl-token initialize-metadata mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k <YOUR_TOKEN_NAME> <YOUR_TOKEN_SYMBOL> <YOUR_TOKEN_URI>`, and sign with the mint authority.

Address:  mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k
Decimals:  9

Signature: 3FQuaTBnFZQMv4v6kz9ZXNbTLXe9t8rBjEPbeQpBZsEqtVHLCnLS49BWshHzk9FydKCLNmYeVXc6k49dvPEoSkYN
```

> If desired, this is also the time to add additional token extensions to your token to have extra functionality, for example transfer fees.{: .prompt-warning}

## Set Up Token Metadata (e.g., name, symbol)

Next, we will create the offchain metadata for our token. This data is displayed on sites like Solana Explorer when people look at our token mint address.

>The image should be square, and either 512x512 or 1024x1024 pixels, and less than 100kb if possible.
{: .prompt-info}

Metadata and media referenced inside (like the image ) must be saved somewhere publicly accessible online.

For production tokens, a decentralized storage service like one of the following is considered more appropriate:

* Akord - uploads to Arweave; free without sign up for 100Mb; uploads can take a while
* Irys - formerly known as Bundlr, uploads to Arweave
* Metaboss - by Metaplex
* NFT Storage - used by many popular projects
* Pinata - uploads to IPFS; free with sign up for 1Gb
* ShadowDrive - a Solana native storage solution
* web3.storage - requires signing up for a free plan - first 5Gb are free, easy to use

>For a test token, a centralized storage solution like AWS S3, GCP, or GitHub (using the 'raw' URL format https://raw.githubusercontent.com/... ) is fine.{: .prompt-info}

### Upload the image

Upload your image file to your desired online storage solution and get the link. Ensure that the link directly opens your image file!

```bash
https://raw.githubusercontent.com/solana-developers/opos-asset/main/assets/CompressedCoil/image.png
https://avatars.githubusercontent.com/u/144523105
https://raw.githubusercontent.com/DangerDrome/DangerOS/fc4d13e57f73ae80edccb4f0f750be33b317193e/distro/rocky/media/brand/logo/rocky-logo.png
```

### Create and Upload the offchain metadata file

Create a `metadata.json` file, add a name, symbol and description plus the image you just uploaded:

```json
{
  "name": "Compute Coin",
  "symbol": "COMP",
  "description": "Compute Coin Devnet Token.",
  "image": "https://raw.githubusercontent.com/DangerDrome/DangerOS/fc4d13e57f73ae80edccb4f0f750be33b317193e/distro/rocky/media/brand/logo/rocky-logo.png"
}
```
Then upload the metadata.json to the storage provider of your choice (GitHub for Devnet).

```
https://raw.githubusercontent.com/diegotrazzi/diegotrazzi.github.io/refs/heads/main/assets/Solana/metadata.json
```

### Add the metadata to the token

>This step only works for tokens using the Token Extensions program (TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb)
{: .prompt-warning}

Now we will initialize the metadata for our token with the metadata we just created and uploaded.

```bash
spl-token initialize-metadata mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k 'Compute Coin' 'COMP' https://raw.githubusercontent.com/diegotrazzi/diegotrazzi.github.io/refs/heads/main/assets/Solana/metadata.json
```

Congratulations, you created a token with metadata! Look at your token's mint address (starting with mnt) in Solana Explorer - making sure to to use devnet (if you are working on devnet).

You can check the token details on [explorer.solan.com](https://explorer.solana.com/?cluster=devnet)

`https://explorer.solana.com/address/mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k?cluster=devnet`

![CC Token](/assets/Solana/ComputeToken.png){: .centered width="1000"}

## Mint Tokens

To mint a certain amount of tokens we need an account:

```bash
spl-token create-account mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k

Creating account 4rawtUfJmygmeZAteL6JhQ7fDa19k8YSQKTTYZbbHSyg

Signature: 2taEpJEhiHorywXMiXG4CxMmL2nzs59SAPHW7aEKVxWkkXdAx6Zg35r1XX7NFbbvov98N3qqo9fhwcFJKGQ5xfMm
```

This will create a new token account for the account that is currently set in the Solana config. You can also specify a different account by adding the address at the end of the command.

And now we can finally mint some tokens into that token account:

```bash
spl-token mint <your-token-address> <amount> <your-token-account-address>
```

For example, to mint 1B tokens:

```bash
spl-token mint mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k 1000000000

Minting 1000000000 tokens
  Token: mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k
  Recipient: 4rawtUfJmygmeZAteL6JhQ7fDa19k8YSQKTTYZbbHSyg

Signature: nbF5H95Pv4MHod49utdd6ajkw7wSf8XgcQ7zut9NRZ8CZP5G22ALeCQeaKnBZ2tdQbzx9LkTkUmimHGXKsDdfjD
```

### Verify Token Creation

You can verify the token creation and balance by running:

```bash
spl-token accounts

Token                                         Balance   
--------------------------------------------------------
mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k   1000000000
```

This will show your token balances.

### Send tokens to another account

Now you can also send the token to another owner of the tokens, for example:

```bash
spl-token transfer mntvsoCFUAjDagq1BQirJpU1xL9GWJ94i3U17tv3k9k 500000000 (recipient wallet address) --fund-recipient
```

### References:
* [Install Solana Cli](https://solana.com/docs/intro/installation)
* [How to create a token](https://solana.com/developers/guides/getstarted/how-to-create-a-token)
* [How to use transfer fee extension](https://solana.com/developers/guides/token-extensions/transfer-fee)
