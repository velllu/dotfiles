{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.bundles.graphics;
in
{
  options.modules.bundles.graphics = {
    enable = mkEnableOption "Enable graphics software";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      kdePackages.kdenlive
    ];
  };
}
