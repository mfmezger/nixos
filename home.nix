{ config, pkgs, ... }:

{
  home.username = "mfm";
  home.homeDirectory = "/home/mfm";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
#   xresources.properties = {
#     "Xcursor.size" = 16;
#     "Xft.dpi" = 172;
#   };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    eza # A modern replacement for ‘ls’

    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    bptop  # replacement of htop/nmon
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Marc Fabian Mezger";
    userEmail = "marc.mezger@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}