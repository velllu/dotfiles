{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../modules
  ];

  config = {
    modules = {
      discord.enable = true;
      firefox.enable = true;
      helix.enable = true;
      quickshell.enable = true;
      swayfx.enable = true;
      terminal.enable = true;
      virtualization.enable = false;

      bundles = {
        coding.enable = true;
        extra.enable = false;
        gaming.enable = false;
        graphics.enable = true;
      };
    };
  };
}
