{ config, pkgs, inputs, ... }:

let
 inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in
{
  config = {
    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" "docker" "plugdev" "dialout" ];

      # `dialout` is for the raspberry pi pico
    };

    # When running in a vm set a default password
    virtualisation.vmVariant = {
      users.users."${config.vellu.userData.username}" = {
        initialPassword = "vm";
      };
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;

      # Config files
      xdg.configFile."scripts".source = ../scripts;
      xdg.configFile."wallpaper".source = ../wallpapers/sage.png;

      # Bar config
      xdg.configFile."quickshell/shell.qml".source = ../quickshell/shell.qml;

      xdg.configFile."quickshell/MyText.qml".text = ''
        import QtQuick

        Text {
            font.family: "${config.vellu.theming.font}"
            font.pixelSize: 17
            color: Colorscheme.foreground
        }
      '';

      xdg.configFile."quickshell/Colorscheme.qml".text = ''
        pragma Singleton
        import QtQuick

        QtObject {
            property string background: "#${config.vellu.theming.colorScheme.palette.base00}"
            property string foreground: "#${config.vellu.theming.colorScheme.palette.base06}"
            property string workspaceColor: "#${config.vellu.theming.colorScheme.palette.base08}"
            property string februaryColor: "#${config.vellu.theming.colorScheme.palette.base0A}"
            property string dateColor: "#${config.vellu.theming.colorScheme.palette.base0D}"
            property string resourcesColor: "#${config.vellu.theming.colorScheme.palette.base0C}"
        }
      '';

      # GTK theme
      gtk = {
        enable = true;
        theme = {
          name = config.vellu.theming.colorScheme.slug;
          package = gtkThemeFromScheme {scheme = config.vellu.theming.colorScheme;};
        };
      };
    };
  };
}
