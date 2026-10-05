{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.bar;
in
{
  options.modules.bar = {
    enable = mkEnableOption "Enable the custom bar";

    hasBattery = mkOption {
      type = types.bool;
      default = false;
      description = "Wheter to include a battery percentage widget";
    };
  };

  config = mkIf cfg.enable {
    programs.bar = {
      enable = true;
      hasBattery = cfg.hasBattery;
      font = config.stylix.fonts.sansSerif.name;
      colors = with config.lib.stylix.colors.withHashtag; {
        background = base00;
        foreground = base06;
        red = base08;
        orange = base09;
        yellow = base0A;
        purple = base0E;
        blue = base0D;
        lightBlue = base0C;
        lightBackground = base03;
      };
    };

    # This program prints the battery percentage and wheter it is chargin or not
    environment.systemPackages = mkIf cfg.hasBattery [ pkgs.acpi ];
  };
}
