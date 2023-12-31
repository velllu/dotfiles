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
      bspwm
      catppuccin-gtk
      clang-tools
      distrobox
      dunst
      emote
      eza
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
      grapejuice
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
      neofetch
      neovim
      nil
      nixpkgs-unstable.legacyPackages."${pkgs.system}".ollama
      ntfs3g
      obsidian
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
      tealdeer
      tokei
      tor-browser-bundle-bin
      transmission-gtk
      unzip
      vesktop
      via
      virtiofsd
      virt-manager
      vscodium
      wget
      wineWowPackages.full
      xorg.xkill
      yt-dlp
    ];

    # Iosevka font
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];

    # Emacs config
    home-manager.users."${config.vellu.userData.username}" = { pkgs, ... }: {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs29-gtk3;
        extraPackages = epkgs: [
          epkgs.all-the-icons
          epkgs.all-the-icons-ivy-rich
          epkgs.catppuccin-theme
          epkgs.company
          epkgs.company-box
          epkgs.counsel
          epkgs.dashboard
          epkgs.doom-themes
          epkgs.eldoc-box
          epkgs.esup
          epkgs.evil
          epkgs.highlight-indent-guides
          epkgs.ivy-rich
          epkgs.linum-relative
          epkgs.markdown-mode
          epkgs.mini-frame
          epkgs.nix-mode
          epkgs.org-bullets
          epkgs.rust-mode
          epkgs.treesit-auto
          epkgs.yaml-mode
        ];
      };
    };
  };
}
