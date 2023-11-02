{ pkgs, nixpkgs-unstable, config, ... }:

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
      grapejuice
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

    # Iosevka font
    fonts.fonts = with pkgs; [
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
