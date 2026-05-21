{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.discord;
in
{
  options.modules.discord = {
    enable = mkEnableOption "Enable discord theming";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
    ];

    home-manager.users."${config.vellu.userData.username}" =
      { config, ... }:
      {
        # Stylix sets the theme in the vencord theme folder, but we set it to the quickcss
        # so it is loaded without user input
        xdg.configFile."vesktop/settings/quickCss.css".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/Vencord/themes/stylix.theme.css";
      };
  };
}
