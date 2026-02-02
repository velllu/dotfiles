{ config, lib, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      programs.alacritty.enable = true;
      programs.alacritty.settings = {
        window = {
          padding = {
            x = 15;
            y = 15;
          };

          opacity = 0.9;
        };

        colors = with config.lib.stylix.colors.withHashtag; {
          cursor = {
            text = lib.mkForce base05;
            cursor = lib.mkForce base05;
          };
        };
      };
    };
  };
}
