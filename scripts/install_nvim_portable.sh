#!/bin/sh

# install Neovim locally if not present
if ! command_exists nvim; then
    echo "Neovim not found, installing locally..."

    if [ "$machine" = "Linux" ]; then
        curl -L \
          https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz \
          -o nvim-linux-x86_64.tar.gz
        tar xzf nvim-linux-x86_64.tar.gz
        rm nvim-linux-x86_64.tar.gz
        mv nvim-linux-x86_64 "$HOME/Applications/nvim-linux-x86_64"
        ln -sfn "$HOME/Applications/nvim-linux-x86_64/bin/nvim" "$HOME/bin/nvim"

    elif [ "$machine" = "Mac" ]; then
        curl -L \
          https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz \
          -o nvim-macos-arm64.tar.gz
        xattr -c nvim-macos-arm64.tar.gz || true
        tar xzf nvim-macos-arm64.tar.gz
        rm nvim-macos-arm64.tar.gz
        mv nvim-macos-arm64 "$HOME/Applications/nvim-macos-arm64"
        ln -sfn "$HOME/Applications/nvim-macos-arm64/bin/nvim" "$HOME/bin/nvim"
    else
        echo "Neovim installation skipped: unsupported platform ($machine)"
    fi
else
    echo "Neovim already installed, skipping."
fi
