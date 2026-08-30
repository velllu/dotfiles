{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.omp;

  ompFiles = builtins.fetchGit {
    url = "https://github.com/can1357/oh-my-pi.git";
    rev = "4854db856c20e000a3760d793c56d78065dcf83f";
  };

  imageName = "oh-my-pi/pi:local";
in
{
  options.modules.omp = {
    enable = mkEnableOption "Enable oh-my-pi AI agent";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;

      oci-containers = {
        backend = "docker";
        containers.omp = {
          image = "oh-my-pi/pi:local";
          autoStart = true;
        };
      };
    };

    systemd.services."docker-omp".preStart = ''
      ${pkgs.docker}/bin/docker image inspect '${imageName}' >/dev/null 2>&1 || \
        ${pkgs.docker}/bin/docker build --pull -t '${imageName}' ${ompFiles}
    '';

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "omp" ''
        exec ${pkgs.docker}/bin/docker run --rm -it \
          --network host \
          -v omp-home:/root \
          -w /workspace \
          --entrypoint /usr/local/bin/omp \
          ${imageName} "$@"
      '')

      (pkgs.writeShellScriptBin "omp-project" ''
        exec ${pkgs.docker}/bin/docker run --rm -it \
          --network host \
          -v omp-home:/root \
          -w /workspace \
          -v "''${PWD}":/workspace \
          --entrypoint /usr/local/bin/omp \
          ${imageName} "$@"
      '')
    ];
  };
}
