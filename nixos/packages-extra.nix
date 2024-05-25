{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      godot_4
      heroic
      jetbrains.idea-community
      kdenlive
      mangohud
      prismlauncher
      reaper
      tor-browser-bundle-bin
    ];
  };
}
