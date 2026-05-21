{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
let
  cfg = config.modules.quickshell;
in
{
  options.modules.quickshell = {
    enable = mkEnableOption "Enable quickshell";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.quickshell.packages.${stdenv.hostPlatform.system}.default
    ];

    home-manager.users."${config.vellu.userData.username}" = {
      xdg.configFile."quickshell/shell.qml".source = ./shell.qml;

      # Hard code colors and fonts so it changes with stylix
      xdg.configFile."quickshell/MyText.qml".text = ''
        import QtQuick

        Text {
            font.family: "${config.stylix.fonts.sansSerif.name}"
            font.pixelSize: 17
            color: Colorscheme.foreground
        }
      '';

      xdg.configFile."quickshell/Colorscheme.qml".text = with config.lib.stylix.colors.withHashtag; ''
        pragma Singleton
        import QtQuick

        QtObject {
            property string background: "${base00}"
            property string foreground: "${base06}"

            property string workspaceColor: "${base08}"
            property string februaryColor: "${base09}"
            property string trayColor: "${base0A}"

            property string dateColor: "${base0E}"
            property string resourcesColor: "${base0D}"
            property string volumeColor: "${base0C}"
            property string volumeDarkColor: "${base03}"
        }
      '';
    };
  };
}
