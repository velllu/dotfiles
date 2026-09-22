{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.servers.open-webui;
in
{
  options.modules.servers.open-webui = {
    enable = mkEnableOption "Enable open-webui server";
  };

  config = mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      environment.WEBUI_AUTH = "False";
    };
  };
}
