{
  description = "My quickshell config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      quickshell,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      defaultFont = "FreeMono";

      defaultColors = {
        background = "#000000";
        foreground = "#ffffff";
        red = "#ff0000";
        orange = "#ff9900";
        yellow = "#fff700";
        purple = "#9300fc";
        blue = "#002efc";
        lightBlue = "#5673f5";
        lightBackground = "#313244";
      };

      mkConfigFolder =
        font: colors:
        pkgs.linkFarm "quickshell-config" [
          {
            name = "shell.qml";
            path = ./shell.qml;
          }
          {
            name = "MyText.qml";
            path = pkgs.writeText "MyText.qml" ''
              import QtQuick

              Text {
                  font.family: "${font}"
                  font.pixelSize: 17
                  color: Colorscheme.foreground
              }
            '';
          }
          {
            name = "Colorscheme.qml";
            path = pkgs.writeText "Colorscheme.qml" ''
              pragma Singleton
              import QtQuick

              QtObject {
                  property string background: "${colors.background}"
                  property string foreground: "${colors.foreground}"

                  property string workspaceColor: "${colors.red}"
                  property string februaryColor: "${colors.orange}"
                  property string trayColor: "${colors.yellow}"

                  property string dateColor: "${colors.purple}"
                  property string resourcesColor: "${colors.blue}"
                  property string volumeColor: "${colors.lightBlue}"
                  property string volumeDarkColor: "${colors.lightBackground}"
              }
            '';
          }
        ];

      # QT_QPA_PLATFORMTHEME must be unset because it's qt5ct by default and that
      # makes quickshell not launch
      mkBarScript =
        font: colors:
        pkgs.writeShellScriptBin "bar" ''
          unset QT_QPA_PLATFORMTHEME
          exec ${quickshell.packages.${system}.default}/bin/quickshell \
            --path "${mkConfigFolder font colors}" "$@"
        '';
    in
    {
      packages.${system}.default = mkBarScript defaultFont defaultColors;

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/bar";
      };

      nixosModules.default =
        {
          config,
          lib,
          ...
        }:
        let
          cfg = config.programs.bar;
        in
        {
          options.programs.bar = {
            enable = lib.mkEnableOption "Enable bar";

            font = lib.mkOption {
              type = lib.types.str;
              default = defaultFont;
            };

            colors = lib.mkOption {
              type = lib.types.attrsOf lib.types.str;
              default = defaultColors;
            };
          };

          config = lib.mkIf cfg.enable {
            environment.systemPackages = [
              (mkBarScript cfg.font cfg.colors)
            ];
          };
        };
    };
}
