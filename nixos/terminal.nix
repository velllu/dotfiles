{ pkgs, ... }:

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
        pfetch

        set -U fish_greeting # disable greeting
        fish_vi_key_bindings
      '';

      shellAliases = {
        cat = "bat --style plain -P";
        clear = "clear && pfetch";
        grep = "rg";
        less = "moar";
        ls = "exa --long --icons --git --no-permissions";
        man = "batman";
        nvim = "echo Remember that you switched to helix!! && echo senile dementia && false";
        s = "ls";
        switc = "sudo nixos-rebuild switch";
        tree = "exa --tree --icons --git-ignore";
      };
    };
  };
}
