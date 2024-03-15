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

        set -l foreground ${config.vellu.theming.colorScheme.colors.base07}
        set -l selection ${config.vellu.theming.colorScheme.colors.base01}
        set -l comment ${config.vellu.theming.colorScheme.colors.base00}
        set -l red ${config.vellu.theming.colorScheme.colors.base08}
        set -l orange ${config.vellu.theming.colorScheme.colors.base09}
        set -l yellow ${config.vellu.theming.colorScheme.colors.base0A}
        set -l green ${config.vellu.theming.colorScheme.colors.base0B}
        set -l purple ${config.vellu.theming.colorScheme.colors.base0E}
        set -l cyan ${config.vellu.theming.colorScheme.colors.base0C}

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $cyan
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $orange
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $orange
        set -g fish_color_autosuggestion $yellow

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set -g fish_pager_color_selected_background --background=$selection
      '';

      shellAliases = {
        cat = "bat --style plain -P";
        clear = "clear && fastfetch -l nixos_small";
        grep = "rg";
        less = "moar";
        ls = "eza --long --icons --git --no-permissions --sort type";
        man = "batman";
        s = "ls";
        switc = "sudo nixos-rebuild switch";
        tree = "eza --tree --icons --git-ignore";
      };
    };
  };
}
