{ pkgs, nixpkgs-unstable, ... }:

{
  config = {
    programs.sway = {
      enable = true;
      package = nixpkgs-unstable.legacyPackages."${pkgs.system}".swayfx;
    };

    services.xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
        gnome.enable = true;
      };
   
      displayManager = {
        defaultSession = "none+bspwm";
      };

      windowManager.bspwm = {
        enable = true;
      };
    };
  };
}
