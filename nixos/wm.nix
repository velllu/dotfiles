{ ... }:

{
  config = {
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
