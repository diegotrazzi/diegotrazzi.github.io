---
layout: post
title: Install Solana CLI on MacOS
categories: [Crypto]
tags: [Solana, crypto, cli]
date: 2024-12-20 20:29 +1300
---

# Installing Solana Client on Mac

Follow these steps to install the Solana client on your Mac:

## Step 1: Install Homebrew (if not already installed)

Open Terminal and run:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify Homebrew installation:

```bash
brew --version
```

## Step 2: Install the Solana CLI

Run the following command to install the Solana CLI:

```bash
sh -c "$(curl -sSfL https://release.anza.xyz/stable/install)"
```

Reload the shell configuration:

```bash
source ~/.zshrc   # For zsh users
source ~/.bash_profile   # For bash users
```

## Step 4: Verify Installation

Check the installed Solana version:

```bash
solana --version
```

If the version displays, the installation was successful.

## Step 5: Update Solana CLI (Optional)

To update the Solana CLI in the future, run:

```bash
solana-install update
```

Now you’re ready to use the Solana CLI on your Mac!

### References:
* [Install Solana Cli](https://solana.com/docs/intro/installation)