{ config, ... }:

{
  config = {
    home-manager.users."${config.vellu.userData.username}" = {
      programs.helix.enable = true;

      programs.helix.settings = {
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

      programs.helix.languages = {
        language = [{ name = "python"; language-servers = [ "pyright" ]; }];
      };
    };
  };
}
