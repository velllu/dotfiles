{
  config,
  lib,
  pkgs-unstable,
  ...
}:

with lib;
let
  cfg = config.modules.servers.trilium-server;
in
{
  options.modules.servers.trilium-server = {
    enable = mkEnableOption "Enable trilium server for note syncing";
  };

  config = mkIf cfg.enable {
    services.trilium-server = {
      enable = true;
      package = pkgs-unstable.trilium-server;
      host = "0.0.0.0";
      port = 6767;
    };

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 6767 ];
      };
    };
  };
}
