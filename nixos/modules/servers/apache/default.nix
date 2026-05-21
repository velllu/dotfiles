{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.servers.apache;
in
{
  options.modules.servers.apache = {
    enable = mkEnableOption "Enable debug apache server meant for running PHP";

    documentRoot = mkOption {
      type = types.str;
      default = "/var/my-website";
      description = "The path at which the HTML/PHP files are stored";
    };
  };

  config = mkIf cfg.enable {
    services.httpd = {
      enable = true;
      enablePHP = true;
      virtualHosts."localhost".documentRoot = cfg.documentRoot;
    };
  };
}
