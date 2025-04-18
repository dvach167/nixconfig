{
  description = "NixOS configuration using flakes for two hosts";

  inputs = {
    # Use the unstable channel (you might want to pin to a specific revision)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager for user configurations (if needed later)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    nvf.url = "github:notashelf/nvf";

    niri.url = "github:sodiboo/niri-flake";

    sf-pro = {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      flake = false;
    };

    stylix.url = "github:danth/stylix";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.yapperchino = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        # Host configuration file for the Framework laptop
        stylix.nixosModules.stylix
        ./hosts/yapperchino/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dom = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            hostname = "yapperchino";
          };
        }
      ];
    };

    nixosConfigurations.sitterchino = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        # Host configuration file for the desktop system
        ./hosts/sitterchino/configuration.nix
      ];
    };
  };
}
