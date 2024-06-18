{ pkgs, ... }:

{
  config = {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      package = pkgs.swayfx;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
