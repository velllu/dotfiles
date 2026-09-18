{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.raspberry-pico;
in
{
  options.modules.raspberry-pico = {
    enable = mkEnableOption "Enable raspberry pi pico debugging";
  };

  config = mkIf cfg.enable {
    # These must be set to flash the raspberry pico without root
    services = {
      udev.extraRules = builtins.readFile ./udev-rules;
      udisks2.enable = true;
    };

    users.users."${config.vellu.userData.username}" = {
      extraGroups = [
        "dialout"
      ];
    };
  };
}
