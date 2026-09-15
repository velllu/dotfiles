{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };

      # Template
      mkSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              self
              inputs
              outputs
              pkgs-unstable
              ;
          };
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "bak";
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

        laptop = mkSystem [
          ./nixos/hosts/laptop
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
