{ pkgs, nixpkgs-unstable, config, ... }:

{
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.6"
      "electron-25.9.0"
    ];

    environment.systemPackages = with pkgs; [
      acpi
      alacritty
      alsa-utils
      bat
      bat-extras.batman
      blender
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
      gimp
      git
      gnome.gnome-font-viewer
      gnome-secrets
      godot_4
      helix
      heroic
      htop
      kdenlive
      killall
      libqalculate
      lutris
      mangohud
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
      poetry
      polkit_gnome
      polybar
      prismlauncher
      reaper
      ripgrep
      rofi
      simplescreenrecorder
      superTuxKart
      swayfx
      sxhkd
      tealdeer
      tokei
      tor-browser-bundle-bin
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
