{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../modules
  ];

  config = {
    modules = {
      bar.enable = true;
      discord.enable = true;
      firefox.enable = true;
      helix.enable = true;
      raspberry-pico.enable = true;
      swayfx.enable = true;
      terminal.enable = true;
      virtualization.enable = true;

      bundles = {
        coding.enable = true;
        extra.enable = true;
        gaming.enable = true;
        graphics.enable = true;
      };

      servers = {
        open-webui.enable = true;
        trilium-server.enable = true;
      };
    };
  };
}
