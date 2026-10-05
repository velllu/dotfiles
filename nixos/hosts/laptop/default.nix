{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../modules
  ];

  config = {
    modules = {
      bar = {
        enable = true;
        hasBattery = true;
      };

      discord.enable = true;
      firefox.enable = true;
      helix.enable = true;
      hermes-agent.enable = false;
      moonshine.enable = false;
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
