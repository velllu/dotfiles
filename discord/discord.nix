{ config, lib, pkgs, stylix, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = { config, ... }: {
      # Stylix sets the theme in the vencord theme folder, but we set it to the quickcss
      # so it is loaded without user input
      xdg.configFile."vesktop/settings/quickCss.css".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/Vencord/themes/stylix.theme.css";
    };
  };
}
