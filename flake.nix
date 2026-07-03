{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      # Template
      mkSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs outputs; };
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
          ]
          ++ modules; # Append host-specific modules
        };
    in
    {
      nixosConfigurations = {
        # Main desktop configuration
        nixos = mkSystem [
          ./nixos/hosts/desktop
        ];
      };

      templates = {
        python = {
          path = ./nixos/templates/python;
          description = "Python development flake";
        };

        rust = {
          path = ./nixos/templates/rust;
          description = "Rust development flake";
        };

        javascript = {
          path = ./nixos/templates/javascript;
          description = "JavaScript development flake";
        };
      };
    };
}
