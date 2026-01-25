{ config, pkgs, inputs, osConfig, ... }:

let
  cfg = osConfig.vellu;
in
{
  config = {
    xdg.configFile."quickshell/shell.qml".source = ../quickshell/shell.qml;

    xdg.configFile."quickshell/MyText.qml".text = ''
      import QtQuick

      Text {
          font.family: "${cfg.theming.font}"
          font.pixelSize: 17
          color: Colorscheme.foreground
      }
    '';

    xdg.configFile."quickshell/Colorscheme.qml".text = ''
      pragma Singleton
      import QtQuick

      QtObject {
          property string background: "${config.lib.stylix.colors.withHashtag.base00}"
          property string foreground: "${config.lib.stylix.colors.withHashtag.base06}"
          property string workspaceColor: "${config.lib.stylix.colors.withHashtag.base08}"
          property string februaryColor: "${config.lib.stylix.colors.withHashtag.base0A}"
          property string dateColor: "${config.lib.stylix.colors.withHashtag.base0D}"
          property string resourcesColor: "${config.lib.stylix.colors.withHashtag.base0C}"
      }
    '';
  };
}
