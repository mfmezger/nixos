{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  nix.optimise.automatic = true;
  # EXPERIMENTAL FEATURES
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Garbage collection settings. https://nixos.wiki/wiki/Storage_optimization
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # NVIDIA
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "eu";
    xkb.variant = "";
  };

  programs.steam = {
    enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.displayManager.sddm.wayland.enable = true;
services.displayManager.sddm = {
    enable = true; # Enable SDDM.
    sugarCandyNix = {
        enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
        settings = {
          # Set your configuration options here.
          # Here is a simple example:
          Background = lib.cleanSource ./wallpapers/1.png.png;
          # ScreenWidth = 1920;
          # ScreenHeight = 1080;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
        };
      };
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.fontconfig.enable = true;

  # USER ACCOUNT
  users.users.mfm = {
    isNormalUser = true;
    description = "mfm";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      zip
      xz
      unzip
      bat
      tealdeer
      eza
      brave
      yazi
      fastfetch
      atuin
      btop
      oh-my-zsh
      zoxide
      zenith
      gh
      obsidian
      neovim
      pyenv
      shotcut
      htop
      vscode
      alejandra
      pamixer
      ollama
      (nerdfonts.override {fonts = ["CascadiaCode" "CascadiaMono"];})
    ];
  };

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    egl-wayland
    home-manager
    pkgs.dunst
    kitty
    firefox-wayland
    rofi-wayland
    libnotify
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    #If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    #Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  hardware = {
    #Opengl
    graphics.enable = true;
  };

  system.stateVersion = "24.05";
}
