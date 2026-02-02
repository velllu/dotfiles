{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      # Template
      mkSystem = modules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs outputs; };
        modules = [
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ] ++ modules; # Append host-specific modules
      };
    in
    {
      nixosConfigurations = {
        # Fully featured system
        # Runnable as the default
        nixos = mkSystem [
          ./nixos/configuration.nix
          ./nixos/extra.nix
        ];

        # Minimal system with heavy applications left out
        # Runnable with `sudo nixos-rebuild switch --flake .#minimal`
        minimal = mkSystem [
          ./nixos/configuration.nix
        ];
      };
    };
}
