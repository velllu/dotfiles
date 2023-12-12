{ config, pkgs, ... }:

{
  config = {
    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" "docker" ];
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;

      # Config files
      xdg.configFile."bspwm".source = ../bspwm;
      xdg.configFile."sxhkd".source = ../sxhkd;
      xdg.configFile."polybar".source = ../polybar;
      xdg.configFile."picom".source = ../picom;
      xdg.configFile."alacritty".source = ../alacritty;
      xdg.configFile."scripts".source = ../scripts;
      xdg.configFile."helix".source = ../helix;
      xdg.configFile."wallpaper".source = ../wallpapers/flowers.jpg;
      home.file.".emacs.d" = { source = ../emacs; recursive = true; };
    
      # GTK theme
      gtk = {
        enable = true;
        theme = {
          name = "Tokyonight-Dark-B";
          package = pkgs.tokyo-night-gtk;
          # package = pkgs.catppuccin-gtk.override {
          #   accents = [ "red" ];
          #   tweaks = [ "rimless" ];
          #   variant = "mocha";
          # };
        };
      };
    };
  };
}
