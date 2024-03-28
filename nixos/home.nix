{ config, pkgs, inputs, ... }:

let
 inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in
{
  config = {
    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" "docker" ];
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;

      # Config files
      xdg.configFile."sxhkd".source = ../sxhkd;
      xdg.configFile."scripts".source = ../scripts;
      xdg.configFile."wallpaper".source = ../wallpapers/sasuke.png;
      xdg.configFile."picom".source = ../picom;

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
