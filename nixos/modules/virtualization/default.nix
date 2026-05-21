{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.virtualization;
in
{
  options.modules.virtualization = {
    enable = mkEnableOption "Enable virtualization";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      # The specs when using `nixos-rebuild build-vm`, these are hard coded
      vmVariant.virtualisation = {
        memorySize = 1024 * 4;
        cores = 6;
      };

      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      virtiofsd
      virt-manager
    ];
  };
}
