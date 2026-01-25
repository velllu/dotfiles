{ pkgs, inputs, ... }:

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
      emote
      eza
      fastfetch
      fd
      ffmpeg
      firefox
      flameshot
      gcc
      git
      git-lfs
      gnome-font-viewer
      gnome-secrets
      grim
      htop
      inputs.quickshell.packages.${stdenv.hostPlatform.system}.default
      killall
      libqalculate
      lm_sensors
      mako
      moor
      mpv
      neovim
      nixpkgs-fmt # Nix language formatter
      ntfs3g
      obsidian
      openjdk8
      p7zip
      pcmanfm
      polkit
      polkit_gnome
      polybar
      ripgrep
      rofi
      simplescreenrecorder
      slurp
      sxhkd
      tealdeer
      tokei
      transmission_4-gtk
      unzip
      uv
      vesktop
      via
      virtiofsd
      virt-manager
      vscode
      wget
      wineWowPackages.full
      wl-clipboard
      xorg.xkill
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];
  };
}
