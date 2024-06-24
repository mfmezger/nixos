alejandra .
echo "Formatting done."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake .  &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"
git push

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available