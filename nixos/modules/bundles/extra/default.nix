{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.bundles.extra;
in
{
  options.modules.bundles.extra = {
    enable = mkEnableOption "Enable extra software";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kicad
      tor-browser
    ];
  };
}
