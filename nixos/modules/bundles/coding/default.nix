{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.bundles.coding;
in
{
  options.modules.bundles.coding = {
    enable = mkEnableOption "Enable coding software";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      godot
      jetbrains.idea-oss
      vscode
      zed-editor
    ];
  };
}
