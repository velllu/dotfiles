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

        set -l foreground c0caf5
        set -l selection 283457
        set -l comment 565f89
        set -l red f7768e
        set -l orange ff9e64
        set -l yellow e0af68
        set -l green 9ece6a
        set -l purple 9d7cd8
        set -l cyan 7dcfff
        set -l pink bb9af7

        # Syntax Highlighting Colors
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set -g fish_pager_color_selected_background --background=$selection
      '';

      shellAliases = {
        cat = "bat --style plain -P";
        clear = "clear && pfetch";
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
