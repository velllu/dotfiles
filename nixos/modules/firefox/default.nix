{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox = {
    enable = mkEnableOption "Enable firefox theming";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.vellu.userData.username}" = {
      programs.firefox = {
        enable = true;

        profiles = {
          default = {
          };
        };
      };

      stylix.targets.firefox.colors.enable = true;
      stylix.targets.firefox.firefoxGnomeTheme.enable = true;
      stylix.targets.firefox.profileNames = [ "default" ];
    };
  };
}
