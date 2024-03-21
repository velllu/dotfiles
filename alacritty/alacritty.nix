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

        font = {
          normal.family = config.vellu.theming.font;
          bold.family = config.vellu.theming.font;
          italic.family = config.vellu.theming.font;
          bold_italic.family = config.vellu.theming.font;
          size = 18.0;
        };

        colors = with config.vellu.theming.colorScheme.palette; {
          bright = {
            black = "0x${base02}";
            blue = "0x${base0D}";
            cyan = "0x${base0C}";
            green = "0x${base0B}";
            magenta = "0x${base0E}";
            red = "0x${base08}";
            white = "0x${base06}";
            yellow = "0x${base09}";
          };

          cursor = {
            cursor = "0x${base06}";
            text = "0x${base06}";
          };

          normal = {
            black = "0x${base02}";
            blue = "0x${base0D}";
            cyan = "0x${base0C}";
            green = "0x${base0B}";
            magenta = "0x${base0E}";
            red = "0x${base08}";
            white = "0x${base06}";
            yellow = "0x${base0A}";
          };

          primary = {
            background = "0x${base00}";
            foreground = "0x${base06}";
          };
        };
      };
    };
  };
}
