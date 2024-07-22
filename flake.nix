{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # swww.url = "github:LGFae/swww";
    # hyprland-plugins = {
    #    url = "github:hyperwm/hyprland-plugins";
    #    #inputs.hyprland.follow = "hyprland";
    # };
  sddm-sugar-candy-nix = {
    url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    # Optional, by default this flake follows nixpkgs-unstable.
    inputs.nixpkgs.follows = "nixpkgs";
  };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,, sddm-sugar-cany-nix
    ...
  }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
sddm-sugar-candy-nix.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mfm = import ./home.nix;
          }
        ];
      };
    };
  };
}
