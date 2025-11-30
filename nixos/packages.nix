{ pkgs, inputs, ... }:

{
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.6"
      "electron-25.9.0"
    ];

    # These are the core packages, for the extras look into the `packages-extra.nix` file
    environment.systemPackages = with pkgs; [
      inputs.quickshell.packages.${system}.default
      p7zip
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
      killall
      libqalculate
      lm_sensors
      moar
      mpv
      neovim
      nil # Nix language lsp
      nixpkgs-fmt # Nix language formatter
      ntfs3g
      mako
      obsidian
      openjdk8
      pcmanfm
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
