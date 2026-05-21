{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
      toolchain = pkgs.rust-bin.fromRustupToolchainFile (
        pkgs.writeText "toolchain.toml" ''
          [toolchain]
          channel = "stable"
          profile = "complete"
        ''
      );
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          toolchain

          # These are needed for some graphic apps to work
          pkgs.libxkbcommon
          pkgs.libGL
          pkgs.wayland
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.xorg.libXi
          pkgs.xorg.libX11
        ];

        # Adding those packages to PATH
        LD_LIBRARY_PATH = builtins.concatStringsSep ":" [
          "${pkgs.xorg.libX11}/lib"
          "${pkgs.xorg.libXi}/lib"
          "${pkgs.libGL}/lib"
        ];
      };
    };
}
