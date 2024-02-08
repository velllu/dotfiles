{ config, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      xsession.windowManager.bspwm = {
        enable = true;

        startupPrograms = config.vellu.other.autostart;

        # Idk how to do this in pure home-manager
        extraConfigEarly = ''
          bspc monitor -d 1 2 3 4 5
        '';

        rules.Emacs.state = "tiled";

        settings = {
          # Monitors
          remove_disabled_monitors = true;
          merge_overlapping_monitors = true;

          # Borders
          normal_border_color = "#${config.vellu.theming.colorScheme.colors.base00}";
          focused_border_color = "#${config.vellu.theming.accent}";
          borderless_monocle = true;
          border_width = 6;

          # Gaps & padding
          window_gap = 10;
          top_padding = 0;
          bottom_padding = 0;
          left_padding = 0;
          right_padding = 0;
          gapless_monocle = true;

          # Tiling
          single_monocle = false;
          split_ratio = 0.50;

          # Controls
          focus_follows_pointer = false;
          pointer_action1 = "move";
          pointer_action2 = "resize_side";
          pointer_action3 = "resize_corner";
          pointer_modifier = "mod4";
        };
      };
    };
  };
}
