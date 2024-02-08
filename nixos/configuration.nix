{ lib, config, inputs, ... }:

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
    ../bspwm/bspwm.nix
    ../helix/helix.nix
    ../polybar/polybar.nix
  ];

  options.vellu = {
    other = lib.mkOption {
      default = {
        autostart = [
          "picom"
          "feh --bg-fill ~/.config/wallpaper"
          "polybar"
          "emote"
          "corectrl"
          "dunst"
        ];
      };
    };

    theming = lib.mkOption {
      default = {
        colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        accent = config.vellu.theming.colorScheme.colors.base08;
        font = "Iosevka Nerd Font";
        isDark = true;
      };
    };

    userData = lib.mkOption {
      default = {
        username = "vellu";
        fullname = "Vellu";
        nixosVersion = "23.11";
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
        extraConfig = ''
          GRUB_CMDLINE_LINUX_DEFAULT="amd_iommu=on iommu=pt video=efifb:off"
        '';
        };
    };

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

      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    hardware = {
      keyboard.qmk.enable = true;
      opengl.driSupport32Bit = true; # for 32 bit wine apps
      opengl.enable = true;
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
