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
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.yapperchino = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        # Host configuration file for the Framework laptop
        ./hosts/yapperchino/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dom = import ./hosts/yapperchino/home.nix;
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
