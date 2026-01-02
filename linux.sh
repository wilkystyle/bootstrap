#!/usr/bin/env bash
set -euo pipefail

################################################################################
# INSTALL APT PACKAGES
################################################################################
export DEBIAN_FRONTEND=noninteractive

apt update -y

apt install -y \
    build-essential \
    curl \
    git \
    python3 \
    python3-dev \
    python3-venv \
    ripgrep \
    unzip \
&& :


################################################################################
# INSTALL UV
################################################################################
curl -LsSf https://astral.sh/uv/install.sh | sh


################################################################################
# INSTALL NEOVIM
################################################################################
INSTALL_DIR="$HOME/.local"
NVIM_REPO="https://github.com/neovim/neovim"

case "$(uname -s)" in
  Linux)
    nvim_os="linux"
    ;;
  Darwin)
    nvim_os="macos"
    ;;
esac

case "$(uname -m)" in
  *x86*)
    nvim_arch="x86_64"
    ;;
  *)
    nvim_arch="arm64"
    ;;
esac

archive_name="nvim-${nvim_os}-${nvim_arch}.tar.gz"
download_url="${NVIM_REPO}/releases/latest/download/${archive_name}"

mkdir -p "$INSTALL_DIR"

curl -fsSL "$download_url" | tar -xz --strip-components=1 -C "$INSTALL_DIR"


################################################################################
# NEOVIM CONFIGURATION
################################################################################
mkdir -p ~/.config
git clone https://www.github.com/wilkystyle/nvim ~/.config/nvim


################################################################################
# COMPLETION MESSAGE
################################################################################
echo "Done. Be sure to run source ~/.bashrc"
