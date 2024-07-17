{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "mfm";
  home.homeDirectory = "/home/mfm";

  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 10;
      lockCmd = "swaylock -i ~/nixos/wallpapers/1.png";
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    wofi
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Marc Fabian Mezger";
    userEmail = "marc.mezger@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "docker" "docker-compose" "zoxide" "poetry" "colorize" "gh" "golang"]; # "zsh-autosuggestions"
      theme = "powerlevel10k/powerlevel10k";
    };

    shellAliases = {
      # GIT
      ghcs = "gh copilot suggest";
      gs = "git status";
      gg = "git add . && git commit -m";
      gp = "git push";
      gcb = "git checkout -b";
      gc = "git checkout";

      # NIX
      update = "sudo nixos-rebuild switch --flake .  --show-trace --verbose";

      # EZA is a custom alias for ls -lah
      ls = "eza -lah";
      l = "eza -lah";
      cat = "bat";
      cd = "z";

      # shutdown and reboot
      rs = "sudo reboot";
      s = "shutdown -h now";
    };

    history = {
      size = 30000;
    };

    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = ../p10k-config/p10k.zsh;
      }
    ];

    # initExtra = "source .p10k.zsh";
    dotDir = ".config/zsh";
    # initExtra = ''
    #   # Powerlevel10k Zsh theme
    #   source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    #   test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh
    # '';
  };

  programs.zoxide = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
  };

  # programs.firefox = {
  #   enable = true;
  #   profiles.mfm = {
  #     search.engines = {
  #       "Nix Packages" = {
  #         urls = [
  #           {
  #             template = "https://search.nixos.org/packages";
  #             params = [
  #               {
  #                 name = "type";
  #                 value = "packages";
  #               }
  #               {
  #                 name = "query";
  #                 value = "{searchTerms}";
  #               }
  #             ];
  #           }
  #         ];

  #         icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  #         definedAliases = ["@np"];
  #       };
  #     };
  #     search.force = true;

  #     bookmarks = [
  #       {
  #         name = "wikipedia";
  #         tags = ["wiki"];
  #         keyword = "wiki";
  #         url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
  #       }
  #       {
  #         name = "NixOS";
  #         tags = ["nix"];
  #         keyword = "nixpackages";
  #         url = "https://search.nixos.org/packages";
  #       }
  #       {
  #         name = "NixBook";
  #         tags = ["nix"];
  #         keyword = "nixpackages";
  #         url = "https://nixos-and-flakes.thiscute.world";
  #       }
  #     ];

  #     extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
  #       ublock-origin
  #       tridactyl
  #       youtube-shorts-block
  #       dashlane
  #       i-dont-care-about-cookies
  #       languagetool
  #       link-cleaner
  #       onetab
  #       privacy-badger
  #     ];
  #   };
  # };

  # Shell History Management
  programs.atuin = {
    enable = true;
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
    ];
  };
  programs.waybar = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font.name = "Cascadia Code";
    keybindings = {
      "super+c" = "copy";
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/nixos/wallpapers/1.jpg"
      ];
      # wallpaper = [
      #   "DP-1,~/nixos/images/.jpg"
      #   "DP-3,~/Pictures/walpapers/wallpaper.jpg"
      # ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    #
    settings = {
      "$mainMod" = "SUPER";
      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 16;
          passes = 2;
          new_optimizations = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      exec-once = ["waybar" "hyprpaper"];

      input = {
        kb_layout = "eu,de";
        kb_options = "grp:caps_toggle";
      };

      bind = [
        "$mainMod, V, exec, rofi -show drun"

        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, files"
        "$mainMod, F, fullscreen,"
        "$mainMod, L, exec, swaylock -i ~/nixos/wallpapers/1.png"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
        ", XF86AudioLowerVolume, exec, pamixer -d 5 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"

        # Waybar
        "$mainMod, B, exec, pkill -SIGUSR1 waybar"
        "$mainMod, W, exec, pkill -SIGUSR2 waybar"
      ];
    };
  };

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
