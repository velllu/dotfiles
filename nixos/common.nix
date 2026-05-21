{
  lib,
  config,
  pkgs,
  ...
}:

# This is used for the basic stuff that most NixOS configs have, this is basically
# boilerplate.

{
  imports = [
    ./home.nix
    ./packages.nix
  ];

  options.vellu = {
    theming = lib.mkOption {
      default = {
        font = "Iosevka Nerd Font";
        borderRadius = 10;
      };
    };

    userData = lib.mkOption {
      default = {
        username = "vellu";
        fullname = "Vellu";
        nixosVersion = "25.11";
        dotfilesPath = "/home/vellu/Projects/dotfiles";
      };
    };
  };

  config = {
    system.stateVersion = config.vellu.userData.nixosVersion;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      opacity.terminal = 0.9;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.iosevka;
          name = config.vellu.theming.font;
        };

        sansSerif = config.stylix.fonts.monospace;
        serif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;

        sizes.terminal = 17;
      };
    };

    environment.sessionVariables = {
      EDITOR = "zeditor";
      EZA_ICON_SPACING = "2";
      GIT_ASKPASS = "";

      # Remaps the caps lock key to the compose key to be able to type accented letters
      XKB_DEFAULT_OPTIONS = "compose:caps";
    };

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

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    systemd = {
      user = {
        services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };

        extraConfig = ''
          DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
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

    nix = {
      package = pkgs.lixPackageSets.stable.lix;

      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      registry = {
        dotfiles.to = {
          type = "path";
          path = config.vellu.userData.dotfilesPath;
        };
      };
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
      git.lfs.enable = true; # Enable large file storage for git
      nix-ld.enable = true;

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

      pulseaudio.enable = false;

      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };

      # These must be set for my raspberry pi pico to work
      udev.extraRules = builtins.readFile ../udev-rules;
      udisks2.enable = true;
    };

    # These make sure that the channel used by `nix-shell` is the same as this flake
    systemd.tmpfiles.rules = [
      "L+ /tmp/nixPath - - - - ${pkgs.path}"
    ];

    nix = {
      nixPath = [ "nixpkgs=/tmp/nixPath" ];
    };
  };
}
