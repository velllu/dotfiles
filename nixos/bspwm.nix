{
  config = {
    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      desktopManager = {
        xterm.enable = false;
      };
   
      displayManager = {
        defaultSession = "none+bspwm";
        sddm.enable = true;
      };

      windowManager.bspwm = {
        enable = true;
      };
    };
  };
}
