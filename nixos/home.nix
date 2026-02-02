{ config, pkgs, inputs, ... }:

{
  config = {
    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;

      # `dialout` is for the raspberry pi pico
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" "docker" "plugdev" "dialout" ];
    };

    # When running in a vm set a default password
    virtualisation.vmVariant = {
      users.users."${config.vellu.userData.username}" = {
        initialPassword = "vm";
      };
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;

      qt.enable = true;

      services.mako = {
        enable = true;
        settings = {
          default-timeout = 5000; # 5s for a notification to disappear
          ignore-timeout = true;
          border-radius = config.vellu.theming.borderRadius;
        };
      };

      programs = {
        rofi.enable = true;
      };

      # Config files
      xdg.configFile."scripts".source = ../scripts;
      xdg.configFile."wallpaper".source = ../wallpapers/flowers.jpg;

      # Bar config
      imports = [ ../quickshell/quickshell.nix ];

      # GTK theme
      gtk = {
        enable = true;

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
  };
}
