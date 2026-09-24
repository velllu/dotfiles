# This is useful for when I need to automate something boring, it's not
# something I have enabled, I enable it temporarily, however, it's important
# to remember to use the terminal backend correctly.
# Remember to pull the chosen image in advance and then use the command
# ```
# hermes config set terminal.docker_image <IMAGE_NAME>
# ```
# to set the terminal docker backend to use that image.

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
let
  cfg = config.modules.hermes-agent;
in
{
  options.modules.hermes-agent = {
    enable = mkEnableOption "Enable hermes-agent";
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.sessionVariables.DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";

    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      hermes-agent
    ];
  };
}
