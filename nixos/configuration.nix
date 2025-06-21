{ lib, config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./sound.nix
    ./home.nix
    ./env.nix
    ./packages.nix
    ./terminal.nix
    ./wm.nix

    ../alacritty/alacritty.nix
    ../helix/helix.nix
    ../sway/sway.nix
  ];

  options.vellu = {
    theming = lib.mkOption {
      default = {
        colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;
        accent = config.vellu.theming.colorScheme.palette.base0D;
        font = "Iosevka Nerd Font";
        isDark = true;
      };
    };

    userData = lib.mkOption {
      default = {
        username = "vellu";
        fullname = "Vellu";
        nixosVersion = "24.05";
      };
    };
  };

  config = {
    system.stateVersion = config.vellu.userData.nixosVersion;

    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }

          menuentry "Poweroff" {
            halt
          }
        '';
      };
    };

    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';

    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [ 3000 ];
      };
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

      # The specs when using `nixos-rebuild build-vm`, these are hard coded
      vmVariant.virtualisation = {
        memorySize = 1024 * 4;
        cores = 6;
      };

      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    hardware = {
      keyboard.qmk.enable = true;

      graphics = {
        enable = true;
        enable32Bit = true; # for 32 bit wine apps
      };
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

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services = {
      flatpak.enable = true;
      xserver.videoDrivers = [ "modesetting" ];
      udev.extraRules = builtins.readFile ../udev-rules;
      udisks2.enable = true;
      # udev.packages = [
      #   (pkgs.stdenv.mkDerivation {
      #     name = "probe-rs-rules";
      #     src = ../probe-rs/69-probe-rs.rules;
      #     dontUnpack = true;
      #     installPhase = ''
      #       mkdir -p $out/lib/udev/rules.d
      #       cp $src $out/lib/udev/rules.d/69-probe-rs.rules
      #     '';
      #   })
      # ];
    };

    security.rtkit.enable = true;

    # These make sure that the channel used by `nix-shell` is the same as this flake
    systemd.tmpfiles.rules = [
      "L+ /tmp/nixPath - - - - ${pkgs.path}"
    ];

    nix = {
      nixPath = [ "nixpkgs=/tmp/nixPath" ];
    };
  };
}
