{ config, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      services.polybar.enable = true;
      services.polybar.script = "polybar bar &";
      services.polybar.settings = {
        colors = with config.vellu.theming.colorScheme.colors; {
          background = "#${base00}";
          foreground = "#${base06}";

          workspaces-color = "#${base08}";
          window-title-color = "#${base09}";
          data-color = "#${base0C}";
          date-color = "#${base0D}";
        };

        settings = {
          screenchange-reload = true;
          pseudo-transparency = true;
        };

        "bar/main" = {
          width = "90%";
          height = "28pt";
          radius = 0;

          offset-x = "5%";
          offset-y = "6pt";

          line-size = 4;
          border-size = 0;
          border-color = "#00000000";

          padding-left = 0;
          padding-right = 0;

          module-margin = 0;

          background = "\${colors.background}";
          foreground = "\${colors.foreground}";
          tray-foreground = "\${colors.background}";

          font-0 = "${config.vellu.theming.font};2";
          font-1 = "${config.vellu.theming.font}:pixelsize=13;1";

          modules-left = "xworkspaces xwindow";
          modules-right = "memory cpu temperature date";
          tray-position = "center";
        };

        "module/xworkspaces" = {
          type = "internal/xworkspaces";
          format-underline = "\${colors.workspaces-color}";

          label-active = "";
          label-active-font = 2;
          label-active-padding = 1;

          label-occupied = "";
          label-occupied-padding = 1;

          label-urgent = "";
          label-urgent-underline = "\${colors.alert}";
          label-urgent-padding = 1;

          label-empty = "";
          label-empty-foreground = "\${colors.disabled}";
          label-empty-padding = 1;

          format-padding = 1;
          reverse-scroll = true;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:50:...%";

          format-underline = "\${colors.window-title-color}";
          format-padding = 1;
        };

        "module/memory" = {
          type = "internal/memory";
          label = "%percentage_used:2%%";

          format-prefix = " ";
          format-prefix-foreground = "\${colors.data-color}";
          format-prefix-font = 2;
          format-underline = "\${colors.data-color}";
          format-padding = 1;

          interval = 2;
        };

        "module/cpu" = {
          type = "internal/cpu";
          label = "%percentage:2%%";

          format-prefix = " ";
          format-prefix-foreground = "\${colors.data-color}";
          format-prefix-font = 2;
          format-underline = "\${colors.data-color}";
          format-padding = 1;
          
          interval = 2;
        };

        "module/temperature" = {
          type = "internal/temperature";

          hwmon-path = "/sys/devices/pci0000:00/0000:00:03.1/0000:2b:00.0/0000:2c:00.0/0000:2d:00.0/hwmon/hwmon2/temp1_input";
          base-temperature = 20;
          warn-temperature = 50;

          format-prefix = " ";
          format-prefix-foreground = "\${colors.data-color}";
          format-underline = "\${colors.data-color}";
          format-prefix-font = 2;
          format-padding = 1;
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;

          date = "%d/%m/%Y %H:%M";
          date-alt = "%d/%m/%Y %H:%M:%S";

          format-prefix = " ";
          format-prefix-foreground = "\${colors.date-color}";
          format-underline = "\${colors.date-color}";
          format-prefix-font = 2;
          format-padding = 1;
        };
      };
    };
  };
}
