{ pkgs, config, ... }:

{
  config = {
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
    programs.fish = {
      enable = true;

      # Load `startup.fish` and also make it so text is always high contrast regardless
      # of the theme
      shellInit = (builtins.readFile ../fish/startup.fish) + ''

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
        switc = "sudo nixos-rebuild switch";
        tree = "eza --tree --icons --git-ignore";
      };
    };
  };
}
