{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
let
  cfg = config.modules.bar;
in
{
  options.modules.bar = {
    enable = mkEnableOption "Enable the custom bar";
  };

  config = mkIf cfg.enable {
    programs.bar = {
      enable = true;
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
  };
}
