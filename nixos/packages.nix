{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  config = {
    environment.systemPackages = with pkgs; [
      pkgs-unstable.trilium-desktop

      acpi
      alsa-utils
      fd
      ffmpeg
      firefox
      foliate
      gcc
      git
      git-lfs
      gnome-font-viewer
      gnome-secrets
      htop
      kdePackages.okular
      killall
      libqalculate
      lm_sensors
      mako
      mpv
      neovim
      nil
      nixd
      nixfmt
      nixpkgs-fmt
      ntfs3g
      openjdk8
      p7zip
      pcmanfm
      polkit
      polkit_gnome
      rofi
      sxhkd
      tealdeer
      tokei
      transmission_4-gtk
      unzip
      wget
      wineWow64Packages.full
      wl-clipboard
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];
  };
}
