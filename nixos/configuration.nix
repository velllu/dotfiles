{ lib, pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./bspwm.nix
    ./sound.nix
    ./home.nix
    ./env.nix
    ./packages.nix
    ./terminal.nix
    ./wm.nix
  ];

  options.vellu.userData = lib.mkOption {
    default = {
      username = "vellu";
      fullname = "Vellu";
      nixosVersion = "23.05";
    };
  };

  config = {
    system.stateVersion = config.vellu.userData.nixosVersion;

    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };

    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
    };

    time.timeZone = "Europe/Rome";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    hardware = {
      keyboard.qmk.enable = true;
      opengl.driSupport32Bit = true; # for 32 bit wine apps
    };

    programs = {
      steam.enable = true;
      corectrl.enable = true;
      dconf.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    xdg = {
      portal.enable = true;
      # portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services = {
      flatpak.enable = true;
      xserver.videoDrivers = [ "modesetting" ];
    };

    security.rtkit.enable = true;
  };
}
