# NixOS Configuration

This NixOS configuration has been migrated from Arch Linux dotfiles to match your workflow.

## Key Changes

### Terminal Emulator
- **Ghostty** (primary terminal from Arch) ✓
- Kitty removed

### Notification Daemon
- **Mako** (Wayland-native, better than Dunst)
- Dunst removed

### Added Packages
All Arch Linux packages migrated:
- kubectl, helm, k9s (Kubernetes)
- git-delta, tokei, fd, dust, tree, jq, glow, chroma, witr
- grim, slurp, wl-clipboard (Wayland tools)
- fzf, ripgrep (better search tools)
- uv, commitizen (Python tools)

### Shell Configuration (Zsh)
- Enhanced with all Arch plugins
- zsh-abbr for abbreviations
- zsh-autosuggestions
- zsh-syntax-highlighting
- zsh-powerlevel10k

### Launcher
- Walker added (Wayland-native, optional alternative to Rofi)

## Installation

1. Copy configuration files:
   ```bash
   sudo cp configuration.nix /etc/nixos/
   sudo cp home.nix /etc/nixos/
   sudo cp flake.nix /etc/nixos/
   sudo cp -r scripts /etc/nixos/
   sudo cp -r p10k-config /etc/nixos/
   sudo cp -r wallpapers /etc/nixos/
   ```

2. Rebuild system:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#nixos
   ```

3. Setup abbreviations (run after first reboot):
   ```bash
   source ~/nixos/scripts/setup-abbreviations.sh
   ```

4. Migrate Neovim config (if using AstroNvim):
   ```bash
   cp -r ../dotfiles/nvim/.config/nvim/ ~/.config/nvim/
   nvim  # Open nvim, plugins will auto-install
   ```

5. Migrate Yazi config:
   ```bash
   cp -r ../dotfiles/yazi/.config/yazi/ ~/.config/yazi/
   ```

## Testing Your Setup

### Test Shell Abbreviations
```bash
# These should expand automatically:
l      # → eza -lah --icons --group-directories-first
cat    # → bat
ff     # → fastfetch
gs     # → git status
gg     # → git add . && git commit -m
k      # → kubectl
```

### Test Terminal
- Super+Return should open Ghostty

### Test Notifications
- Run: `notify-send "Test" "Mako is working"`

### Test Screenshot
```bash
# The script is at: ~/nixos/scripts/screenshot-wayland.sh
# You can bind this in Hyprland config
```

### Test Kubernetes Tools
```bash
kubectl get pods    # Should work
helm version         # Should work
k9s                 # Should open terminal UI
```

### Test Development Tools
```bash
fd test            # Fast file finder
ripgrep pattern    # Fast grep
fzf                # Fuzzy finder
```

## Philosophy

This configuration follows these principles:

1. **Wayland-Native**: All tools optimized for Wayland/Hyprland
   - Ghostty (terminal)
   - Mako (notifications)
   - Walker (launcher, optional)
   - grim+slurp (screenshots)

2. **Keyboard-First**: Everything accessible via keyboard (Super key)

3. **Fast Shell**: zsh with zsh-abbr for instant abbreviations

4. **Beautiful & Productive**: Your Arch setup proven workflow

## Credit

- Inspired by **Omarchy** (DHH's Arch-based distro)
- Your Arch Linux dotfiles
- NixOS community
