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
    emacsPackages.pbcopy
    docker
    docker-compose
    lazydocker
    wev
  ];
  # docker = {
  #   enable = true;
  #   enableOnBoot = false;
  #   # storageDriver = storageDriver;
  #   autoPrune.enable = true;
  # };
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
      update = "sudo nix flake update && sudo nixos-rebuild switch --flake .  --show-trace --verbose";

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
        src = ./p10k-config;
      }
    ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
  };

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
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      monitor = [
        "DP-1,2560x1440@144,auto,1"
        "HDMI-1, 1920x1080, 2560x0, 1"
      ];

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
        "$mainMod SHIFT, left,  movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up,    movewindow, u"
        "$mainMod SHIFT, down,  movewindow, d"

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
        ", F5, exec, pamixer -d 3 "
        ", F6, exec, pamixer -i 3 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"
      ];
    };
  };

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
