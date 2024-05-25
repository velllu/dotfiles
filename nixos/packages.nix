{ pkgs, nixpkgs-unstable, config, ... }:

{
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.6"
      "electron-25.9.0"
    ];

    # These are the core packages, for the extras look into the `packages-extra.nix` file
    environment.systemPackages = with pkgs; [
      acpi
      alacritty
      alsa-utils
      bat
      bat-extras.batman
      distrobox
      dunst
      emote
      eza
      fastfetch
      fd
      feh
      ffmpeg
      firefox
      flameshot
      gcc
      git
      gnome.gnome-font-viewer
      gnome-secrets
      htop
      killall
      libqalculate
      moar
      mpv
      neovim
      nil # Nix language lsp
      nixpkgs-fmt # Nix language formatter
      nixpkgs-unstable.legacyPackages."${pkgs.system}".vesktop
      ntfs3g
      obsidian
      openjdk8
      pcmanfm
      picom
      polkit_gnome
      polybar
      ripgrep
      rofi
      simplescreenrecorder
      sxhkd
      tealdeer
      tokei
      transmission-gtk
      unzip
      via
      virtiofsd
      virt-manager
      vscode
      wget
      wineWowPackages.full
      xorg.xkill
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };
}
