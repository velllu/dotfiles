{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      godot
      jetbrains.idea-oss
      kdePackages.kdenlive
      kicad
      prismlauncher
      tor-browser
    ];
  };
}
