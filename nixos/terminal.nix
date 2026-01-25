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

      shellInit = ''
        fastfetch -l nixos_small

        set -U fish_greeting # disable greeting
        fish_vi_key_bindings
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
