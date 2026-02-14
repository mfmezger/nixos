#!/usr/bin/env bash

# NixOS Migration Installation Script
# This script copies all configuration files to /etc/nixos

set -e  # Exit on error

echo "=========================================="
echo "NixOS Migration Installation"
echo "=========================================="
echo ""

# Check if running as root or can use sudo
if [[ $EUID -eq 0 ]]; then
    SUDO=""
elif command -v sudo; then
    SUDO="sudo"
else
    echo "Error: This script must be run as root or with sudo privileges"
    exit 1
fi

echo "Step 1: Copying configuration files..."
cd /home/mfm/tmp/migration/nixos

$SUDO cp configuration.nix /etc/nixos/
echo "✓ configuration.nix copied"

$SUDO cp home.nix /etc/nixos/
echo "✓ home.nix copied"

$SUDO cp flake.nix /etc/nixos/
echo "✓ flake.nix copied"

$SUDO cp -r scripts /etc/nixos/
echo "✓ scripts directory copied"

$SUDO cp -r p10k-config /etc/nixos/
echo "✓ p10k-config directory copied"

$SUDO cp -r wallpapers /etc/nixos/
echo "✓ wallpapers directory copied"

echo ""
echo "Step 2: Rebuilding NixOS system..."
echo "This may take several minutes..."
$SUDO nixos-rebuild switch --flake /etc/nixos#nixos

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Reboot your system"
echo "2. After reboot, run: source ~/nixos/scripts/setup-abbreviations.sh"
echo "3. Test abbreviations: type 'l', 'cat', 'gs', etc."
echo ""
echo "To migrate Neovim config (AstroNvim):"
echo "  cp -r /home/mfm/tmp/migration/dotfiles/nvim/.config/nvim/ ~/.config/nvim/"
echo ""
echo "To migrate Yazi config:"
echo "  cp -r /home/mfm/tmp/migration/dotfiles/yazi/.config/yazi/ ~/.config/yazi/"
echo ""
echo "See README.md for more details!"
