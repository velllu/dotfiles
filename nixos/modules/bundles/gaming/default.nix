{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.bundles.gaming;
in
{
  options.modules.bundles.gaming = {
    enable = mkEnableOption "Enable gaming software";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];

    programs.steam = {
      enable = true;

      # These make steam big mode run smoothly
      package = pkgs.steam.override {
        extraProfile = ''
          export STEAM_RUNTIME=1
        '';

        extraArgs = "-no-cef-sandbox -cef-force-glx";
      };
    };
  };
}
