{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.servers.mariadb;
in
{
  options.modules.servers.mariadb = {
    enable = mkEnableOption "Enable debug mariadb server";

    username = mkOption {
      type = types.str;
      default = config.vellu.userData.username;
      description = "The username of the root user";
    };

    password = mkOption {
      type = types.str;
      default = "123";
      description = "The password of the root user";
    };

    databaseName = mkOption {
      type = types.str;
      default = "default_database";
      description = "The name of the default database";
    };
  };

  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;

      ensureDatabases = [ cfg.databaseName ];

      ensureUsers = [
        {
          name = cfg.username;
          ensurePermissions = {
            "${cfg.databaseName}.*" = "ALL PRIVILEGES";
          };
        }
      ];

      initialScript = pkgs.writeText "mysql-password.sql" ''
        ALTER USER '${cfg.username}'@'localhost' IDENTIFIED BY '${cfg.password}';
        FLUSH PRIVILEGES;
      '';
    };
  };
}
