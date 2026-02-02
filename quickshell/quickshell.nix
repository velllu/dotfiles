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
}
