{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

# My desktop AMD machine

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/35e69faf-ecb8-4476-afc5-3bfaf506aaff";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5A50-8775";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/4b03689f-2684-41cb-811d-0ec7270f251c"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      rocmPackages.rocminfo
      rocmPackages.hipblas
      rocmPackages.rocblas
    ];
  };

  # Below here are my attempts to configure ROCm

  systemd.tmpfiles.rules = [
    "L+ /opt/rocm - - - - ${
      pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          clr
          hipblas
          rocblas
          clr.icd
        ];
      }
    }"
  ];

  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };
}
