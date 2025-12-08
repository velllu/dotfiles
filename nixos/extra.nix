{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      godot_4
      jetbrains.idea-community
      kdePackages.kdenlive
      prismlauncher
      tor-browser
    ];
  };
}
