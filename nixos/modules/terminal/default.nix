{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.terminal;
  accentColor = config.vellu.theming.accentColor;

  hexToDecimal = hex: lib.trivial.fromHexString hex;

  decimalToHex =
    decimal:
    let
      rawHex = lib.trivial.toHexString decimal;
      padded = lib.strings.fixedWidthString 2 "0" rawHex;
    in
    lib.strings.toLower padded;

  darken =
    hexString: factor:
    let
      r = hexToDecimal (builtins.substring 0 2 hexString);
      g = hexToDecimal (builtins.substring 2 2 hexString);
      b = hexToDecimal (builtins.substring 4 2 hexString);

      newR = builtins.floor (r * factor);
      newG = builtins.floor (g * factor);
      newB = builtins.floor (b * factor);
    in
    "${decimalToHex newR}${decimalToHex newG}${decimalToHex newB}";

  hexToEzaRgb =
    hexStr:
    let
      hexToDec = h: lib.trivial.fromHexString h;
      r = toString (hexToDec (builtins.substring 0 2 hexStr));
      g = toString (hexToDec (builtins.substring 2 2 hexStr));
      b = toString (hexToDec (builtins.substring 4 2 hexStr));
    in
    "38;2;${r};${g};${b}";

  darkenedAccentColor = darken accentColor 0.7;
  ezaColorCode = hexToEzaRgb accentColor;
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
      uutils-coreutils
    ];

    environment.sessionVariables = {
      EZA_COLORS = "fi=${ezaColorCode}:di=1;${ezaColorCode}:ln=${ezaColorCode}:ex=${ezaColorCode}:da=${ezaColorCode}";
    };

    # Has hints when typing the password, which offer a better feedback
    security.sudo-rs.enable = true;

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
        cp = "uutils-cp --progress";
        grep = "rg";
        less = "moor";
        ls = "eza --long --icons --git --no-permissions --sort type";
        man = "batman";
        rm = "uutils-rm --progress";
        s = "ls";
        switc = "sudo nixos-rebuild switch --flake path:${config.vellu.userData.dotfilesPath}";
        template = "echo 'use flake .' > .envrc; nix flake init -t";
        tree = "eza --tree --icons --git-ignore";
      };
    };

    programs.starship = {
      enable = true;

      settings = {
        directory = {
          style = "bold #${darkenedAccentColor}";
        };

        character = {
          success_symbol = "[INS ❯](#${accentColor})";
          error_symbol = "[INS ❯](#${darkenedAccentColor})";
          vimcmd_symbol = "[NOR ❯](blue)";
          vimcmd_replace_one_symbol = "[RLC ❯](cyan)";
          vimcmd_replace_symbol = "[RLC ❯](bright-cyan)";
          vimcmd_visual_symbol = "[VIS ❯](yellow)";
        };
      };
    };

    home-manager.users."${config.vellu.userData.username}" = {
      programs.alacritty = {
        enable = true;

        settings = {
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

      programs.fastfetch = {
        enable = true;

        settings = {
          logo = {
            source = "nixos_small";
            color = with config.lib.stylix.colors; {
              "1" = "#${red}";
              "2" = "#${magenta}";
              "3" = "#${blue}";
              "4" = "#${red}";
              "5" = "#${magenta}";
              "6" = "#${blue}";
              "7" = "#${red}";
              "8" = "#${magenta}";
              "9" = "#${blue}";
            };
          };

          modules = [
            "title"
            "separator"
            "uptime"
            "os"
            "wm"
            "cpu"
            "gpu"
            "disk"
            "battery"
          ];

          display = {
            color = {
              title = "#${accentColor}";
              keys = "#${accentColor}";
              separator = "#${accentColor}";
            };
          };
        };
      };
    };

    users.defaultUserShell = pkgs.fish;
  };
}
