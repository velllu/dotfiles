{ config, lib, pkgs, stylix, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      programs.firefox = {
        enable = true;

        profiles = {
          default = { };
        };
      };

      stylix.targets.firefox.colors.enable = true;
      stylix.targets.firefox.firefoxGnomeTheme.enable = true;
      stylix.targets.firefox.profileNames = [ "default" ];
    };
  };
}
