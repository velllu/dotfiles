{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.moonshine;

  defaultPort = 47989;
  generatePorts = port: offsets: map (offset: port + offset) offsets;

  # If the user is using steam or has steam in the background, when someone tries to open
  # steam through moonshine it causes steam to open in sway rather then in moonshine's
  # compositor, so we kill it first, and then open it again.
  # ["/usr/bin/bash", "-c", "if pgrep -x steam >/dev/null; then /usr/bin/steam -shutdown &>/dev/null; for i in $(seq 1 30); do ! pgrep -x steam >/dev/null && break; sleep 1; done; fi"],
  killSteamScript = pkgs.writeShellScriptBin "kill-steam" ''
    if pgrep -x steam >/dev/null; then
        ${pkgs.steam}/bin/steam -shutdown &>/dev/null
        for i in $(seq 1 30); do
            ! pgrep -x steam >/dev/null && break
            sleep 1
        done
    fi
  '';

  addMachine = pkgs.writeShellScriptBin "add-moonshine-machine" ''
    curl -X POST "http://localhost:${toString defaultPort}/submit-pin" -d "uniqueid=0123456789ABCDEF&pin=$1"
  '';
in
{
  options.modules.moonshine = {
    enable = mkEnableOption "Enable moonshine game streaming";
  };

  config = mkIf cfg.enable {
    # TODO: I should check if there's any way to ONLY open them to devices in LAN.
    networking.firewall = {
      allowedTCPPorts = generatePorts defaultPort [
        (-5)
        0
        1
        21
      ];
      allowedUDPPorts = generatePorts defaultPort [
        9
        10
        11
        13
        21
      ];
    };

    # TODO: This uses the moonshine repo nix flake, but it will get added in the next
    # NixOS version natively.
    services.moonshine = {
      enable = true;
      user = config.vellu.userData.username;

      settings = {
        name = "NixOS";
        address = "0.0.0.0";
        application = [
          {
            title = "Steam";
            command = [
              "${pkgs.steam}/bin/steam"
              "steam://open/bigpicture"
            ];
            pre_command = [
              [ "${killSteamScript}/bin/kill-steam" ]
            ];
          }
        ];
        application_scanner = [
          {
            type = "steam";
            library = "$HOME/.local/share/Steam";
            command = [
              "${pkgs.steam}/bin/steam"
              "-bigpicture"
              "steam://rungameid/{game_id}"
            ];
            pre_command = [
              [ "${killSteamScript}/bin/kill-steam" ]
            ];
          }
        ];
      };
    };

    environment.systemPackages = [ addMachine ];

    users.users."${config.vellu.userData.username}" = {
      extraGroups = [
        "moonshine"
      ];
    };
  };
}
