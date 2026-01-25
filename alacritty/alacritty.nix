{ config, ... }:

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
      };
    };
  };
}
