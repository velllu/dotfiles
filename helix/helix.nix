{ config, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      programs.helix.enable = true;

      programs.helix.settings = {
        theme = "base16";

        editor = {
          indent-guides.render = true;
          rulers = [ 90 ];
          cursorline = true;
          color-modes = true;
        };

        keys.normal = {
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
          "G" = "goto_file_end";
          "esc" = "collapse_selection"; # unselect
        };

        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };

      programs.helix.themes = with config.vellu.theming; {
        base16 = let
          transparent = "none";
          background = "none";

          foreground = if isDark
            then "#${colorScheme.palette.base07}"
            else "#${colorScheme.palette.base00}";

          gray = "#${colorScheme.palette.base01}";
          dark-gray = "#${colorScheme.palette.base02}";
          #white = "#${colorScheme.palette.base07}";
          #black = "#${colorScheme.palette.base00}";
          red = "#${colorScheme.palette.base08}";
          green = "#${colorScheme.palette.base0B}";
          yellow = "#${colorScheme.palette.base0A}";
          orange = "#${colorScheme.palette.base09}";
          blue = "#${colorScheme.palette.base0D}";
          magenta = "#${colorScheme.palette.base0E}";
          cyan = "#${colorScheme.palette.base0C}";
        in {
          "attribute" = cyan;
          "keyword" = { fg = red; };
          "keyword.directive" = red;
          "namespace" = cyan;
          "punctuation" = orange;
          "punctuation.delimiter" = orange;
          "operator" = magenta;
          "special" = magenta;
          "variable.other.member" = blue;
          "variable" = foreground;
          "variable.builtin" = orange;
          "variable.parameter" = foreground;
          "type" = yellow;
          "type.builtin" = yellow;
          "constructor" = { fg = magenta; modifiers = ["bold"]; };
          "function" = { fg = green; modifiers = ["bold"]; };
          "function.macro" = cyan;
          "function.builtin" = yellow;
          "tag" = red;
          "comment" = { fg = green; modifiers = ["italic"]; };
          "constant" = { fg = magenta; };
          "constant.builtin" = { fg = magenta; modifiers = ["bold"]; };
          "string" = green;
          "constant.numeric" = magenta;
          "constant.character.escape" = { fg = foreground; modifiers = ["bold"]; };
          "label" = cyan;
          "module" = cyan;

          "diff.plus" = green;
          "diff.delta" = orange;
          "diff.minus" = red;

          "warning" = orange;
          "error" = red;
          "info" = cyan;
          "hint" = blue;

          "ui.background" = { bg = background; };
          "ui.linenr" = { fg = gray; };
          "ui.linenr.selected" = { fg = yellow; };
          "ui.cursorline" = { bg = gray; };
          "ui.statusline" = { fg = foreground; bg = background; };
          "ui.statusline.normal" = { fg = foreground; bg = background; };
          "ui.statusline.insert" = { fg = foreground; bg = blue; };
          "ui.statusline.select" = { fg = foreground; bg = orange; };
          "ui.statusline.inactive" = { fg = foreground; bg = background; };
          "ui.popup" = { bg = background; };
          "ui.window" = { bg = background; };
          "ui.help" = { bg = background; fg = foreground; };
          "ui.text" = { fg = foreground; };
          "ui.text.focus" = { fg = foreground; };
          "ui.selection" = { bg = background; };
          "ui.selection.primary" = { bg = gray; };
          "ui.cursor.primary" = { bg = foreground; fg = background; };
          "ui.cursor.match" = { bg = background; };
          "ui.menu" = { fg = foreground; bg = background; };
          "ui.menu.selected" = { fg = background; bg = blue; modifiers = ["bold"]; };
          "ui.virtual.whitespace" = background;
          "ui.virtual.ruler" = { bg = gray; };
          "ui.virtual.indent-guide" = { fg = dark-gray; };
          "ui.virtual.inlay-hint" = { fg = gray; };
          "ui.virtual.wrap" = { fg = background; };

          "diagnostic.warning" = { underline = { color = orange; style = "curl"; }; };
          "diagnostic.error" = { underline = { color = red; style = "curl"; }; };
          "diagnostic.info" = { underline = { color = cyan; style = "curl"; }; };
          "diagnostic.hint" = { underline = { color = blue; style = "curl"; }; };

          "markup.heading" = cyan;
          "markup.bold" = { modifiers = ["bold"]; };
          "markup.italic" = { modifiers = ["italic"]; };
          "markup.strikethrough" = { modifiers = ["crossed_out"]; };
          "markup.link.url" = { fg = green; modifiers = ["underlined"]; };
          "markup.link.text" = red;
          "markup.raw" = red;
        };
      };

      programs.helix.languages = {
        language = [{name = "python"; language-servers = ["pyright"];}];
      };
    };
  };
}
