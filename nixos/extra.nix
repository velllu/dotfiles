{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      jetbrains.idea-oss
      kdePackages.kdenlive
      prismlauncher
      tor-browser
    ];
  };
}
