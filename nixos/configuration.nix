{ lib, pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./bspwm.nix
  ];

  options.vellu.userData = lib.mkOption {
    default = {
      username = "vellu";
      fullname = "Vellu";
      nixosVersion = "23.05";
    };
  };

  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

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

    services.xserver.displayManager.sddm.enable = true;
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      # enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    hardware.pulseaudio = {
      enable = false;
    };

    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" ];
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = config.vellu.userData.nixosVersion;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    virtualisation.libvirtd.enable = true;
    programs.dconf.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      docker.enable = true;
    };

    hardware.keyboard.qmk.enable = true;

    programs.steam.enable = true;

    programs.corectrl.enable = true;
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    services.xserver.videoDrivers = [ "modesetting" ];

    # For wine32 bit
    hardware.opengl.driSupport32Bit = true;
  };
}
