{
  config = {
    environment.sessionVariables = {
      EDITOR = "code";
      EZA_ICON_SPACING = "2";
      GIT_ASKPASS = "";
      
      # Remaps the caps lock key to the compose key to be able to type accented letters
      XKB_DEFAULT_OPTIONS = "compose:caps";
    };
  };
}
