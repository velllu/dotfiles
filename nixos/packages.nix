{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      acpi
      alacritty
      alsa-utils
      nixd
      nixfmt
      nil
      fd
      ffmpeg
      firefox
      foliate
      gcc
      git
      git-lfs
      gnome-font-viewer
      gnome-secrets
      grim
      htop
      kdePackages.okular
      killall
      libqalculate
      lm_sensors
      mako
      mpv
      neovim
      nixpkgs-fmt
      ntfs3g
      openjdk8
      p7zip
      pcmanfm
      polkit
      polkit_gnome
      rofi
      slurp
      sxhkd
      tealdeer
      tokei
      transmission_4-gtk
      unzip
      wget
      wineWowPackages.full
      wl-clipboard
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];
  };
}
