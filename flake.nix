{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./nixos/configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # users."${config.vellu.userData.username}" = {
              #   imports = [
              #     # home manager modules
              #   ];

              #   # Let Home Manager install and manage itself.
              #   programs.home-manager.enable = true;
              # };
            };
          }
        ];
      };
    };
  };
}