{ config, lib, pkgs, ... }:

let
  modifier = "Mod4";
in
{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;
        checkConfig = false; # TODO: Remove this when it gets fixed

        config = {
          bars = []; # No sway bar

          keybindings = {
            "${modifier}+Shift+Alt+q" = "swaymsg exit";
            "${modifier}+q" = "kill";
            
            # Window states
            "${modifier}+t" = "floating disable";
            "${modifier}+Shift+t" = "floating enable";
            "${modifier}+s" = "floating toggle";
            "${modifier}+f" = "fullscreen toggle";

            # Focusing
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";

            # Moving windowses
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";

            # Scale windows
            "${modifier}+Alt+h" = "resize shrink width 20px";
            "${modifier}+Alt+j" = "resize grow height 20px";
            "${modifier}+Alt+k" = "resize shrink height 20px";
            "${modifier}+Alt+l" = "resize grow width 20px";
            "${modifier}+Alt+Shift+h" = "resize grow width 20px";
            "${modifier}+Alt+Shift+j" = "resize shrink height 20px";
            "${modifier}+Alt+Shift+k" = "resize grow height 20px";
            "${modifier}+Alt+Shift+l" = "resize shrink width 20px";

            # Switch workspace
            "${modifier}+1" = "workspace 1";
            "${modifier}+2" = "workspace 2";
            "${modifier}+3" = "workspace 3";
            "${modifier}+4" = "workspace 4";
            "${modifier}+5" = "workspace 5";

            # Move to workspace
            "${modifier}+Shift+1" = "move container to workspace 1";
            "${modifier}+Shift+2" = "move container to workspace 2";
            "${modifier}+Shift+3" = "move container to workspace 3";
            "${modifier}+Shift+4" = "move container to workspace 4";
            "${modifier}+Shift+5" = "move container to workspace 5";

            # Shortcuts
            "${modifier}+b" = "exec firefox";
            "${modifier}+Return" = "exec alacritty";
            "${modifier}+d" = "exec rofi -show drun";
            "${modifier}+p" = "exec ~/.config/scripts/power_menu.sh";
            "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
            
            "${modifier}+o" = "layout toggle split"; # Rotate
          };

          gaps = {
            inner = 10;
            outer = 5;
          };

          startup = [
            { command = "${pkgs.swaybg}/bin/swaybg --image ~/.config/wallpaper"; always = true; }
            { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }

            # This is an awful solution, but quickshell seems not to work with symlinks,
            # so I must delete home-manager generated symlinks and replace them as actual
            # files, only then can I start quickshell
            { command = "rm -rf ~/.config/qs && mkdir ~/.config/qs && cp ~/.config/quickshell/* ~/.config/qs/ && rm -rf ~/.config/quickshell/* && mv ~/.config/qs/* ~/.config/quickshell && qs -d -n"; always = true; }

            { command = "emote"; }
            { command = "corectrl"; }
          ];

          fonts = {
            names = [ "${config.vellu.theming.font}" ];
            size = 9.0;
          };

          colors = {
            focused = {
              background = "#${config.vellu.theming.accent}";
              border = "#${config.vellu.theming.accent}";
              childBorder = "#${config.vellu.theming.accent}";
              indicator = "#${config.vellu.theming.accent}";
              text = "#${config.vellu.theming.colorScheme.palette.base00}";
            };
          };

          floating.modifier = "${modifier}";
          focus.followMouse = "no";
        };

        extraConfigEarly = ''
          blur enable
          shadows enable
          corner_radius 10
        '';
      };
    };
  };
}
