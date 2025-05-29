[![Homebrew](https://brew.sh/assets/img/homebrew-social-card.png)](https://brew.sh)


# Homebrew Tap for My Software

This is the official Homebrew tap for distributing software maintained by Brycen. 

Since our binaries are NOT signed ($100 per year!), this was created as a way to distribute my software regardless. 

## Installation

To install any formula from this tap, first add it:

```sh
brew tap BrycensRanch/repo
```

Then you can install whatever you need as normal

```sh
brew install snapx
```

### Bottles (Prebuilt Binaries)
All software in this tap are distributed with Homebrew bottles (prebuilt binaries) for fast and native installation. These bottles are built for the following platforms:

- macOS (Intel on macOS 13, Apple Silicon on 15)
- Ubuntu 24.04 (x86_64, aarch64 (ARM64))

### Cross-platform

I have always prioritized my software to be [cross-platform](https://en.wikipedia.org/wiki/Cross-platform_software). 

However, with Casks, it doesn't allow the application to be installed via Ubuntu. Only macOS.

I have opted to *not* use them even for my GUI applications. It will use a normal formula.

### Feedback & Issues

This repository's issues tab has been disabled. 

If you have any issues with the software distributed here, open an issue in the respective project repository if you encounter any problems.
