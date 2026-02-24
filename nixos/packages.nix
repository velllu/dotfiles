{ pkgs, inputs, ... }:

{
  config = {
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
      nixpkgs-fmt
      ntfs3g
      okular
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
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];
  };
}
