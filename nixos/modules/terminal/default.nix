{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.terminal;
in
{
  options.modules.terminal = {
    enable = mkEnableOption "Enable fish & alacritty configurations";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat
      bat-extras.batman
      eza
      fastfetch
      moor
      ripgrep
    ];

    home-manager.users."${config.vellu.userData.username}" = {
      programs.alacritty.enable = true;
      programs.alacritty.settings = {
        window = {
          padding = {
            x = 15;
            y = 15;
          };

          opacity = 0.9;
        };

        colors = with config.lib.stylix.colors.withHashtag; {
          cursor = {
            text = lib.mkForce base05;
            cursor = lib.mkForce base05;
          };
        };
      };
    };

    programs.fish = {
      enable = true;

      # Load `startup.fish` and also make it so text is always high contrast regardless
      # of the theme
      shellInit = (builtins.readFile ./startup.fish) + ''


        set -g fish_color_param ${config.lib.stylix.colors.base05}
      '';

      shellAliases = {
        cat = "bat --style plain -P";
        clear = "clear && fastfetch -l nixos_small";
        grep = "rg";
        less = "moor";
        ls = "eza --long --icons --git --no-permissions --sort type";
        man = "batman";
        s = "ls";
        switc = "sudo nixos-rebuild switch --flake path:${config.vellu.userData.dotfilesPath}";
        template = "echo 'use flake .' > .envrc; nix flake init -t";
        tree = "eza --tree --icons --git-ignore";
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "[INS ❯](green)";
          error_symbol = "[INS ❯](green)";
          vimcmd_symbol = "[NOR ❯](blue)";
          vimcmd_replace_one_symbol = "[RLC ❯](cyan)";
          vimcmd_replace_symbol = "[RLC ❯](bright-cyan)";
          vimcmd_visual_symbol = "[VIS ❯](yellow)";
        };
      };
    };

    users.defaultUserShell = pkgs.fish;
  };
}
