{ pkgs, ... }:

{
  config = {
    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.6"
    ];

    environment.systemPackages = with pkgs; [
      acpi
      alacritty
      alsa-utils
      bat
      bat-extras.batman
      blender
      bspwm
      catppuccin-gtk
      clang-tools
      discord
      dunst
      emote
      exa
      fd
      feh
      firefox
      flameshot
      gcc
      gimp
      git
      gnome.gnome-font-viewer
      gnome-secrets
      helix
      heroic
      htop
      killall
      libqalculate
      lutris
      moar
      mpv
      neofetch
      neovim
      nil
      ntfs3g
      openjdk8
      pcmanfm
      pfetch
      picom
      poetry
      polkit_gnome
      polybar
      prismlauncher
      ripgrep
      rofi
      superTuxKart
      sxhkd
      tokei
      tor-browser-bundle-bin
      transmission-gtk
      # TODO: Figure out how to install unstable packages
      # unstable.davinci-resolve
      unzip
      via
      virt-manager
      vscodium
      wineWowPackages.full
      xorg.xkill
      yt-dlp
    ];
  };
}
