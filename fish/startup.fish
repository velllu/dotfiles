if set -q IN_NIX_SHELL
  echo "Welcome to a nix shell.."
else if set -q SHLVL; and test "$SHLVL" -gt 1; and string match -q "*/nix/store*" "$PATH"
  echo "Welcome to a nix shell.."
else
  fastfetch -l nixos_small
end

# Converts `nix-shell` calls to `nix shell` calls so it uses the fish shell
function nix-shell
  if contains -- $argv[1] -p --packages # if starts with -p
    set -l pkgs $argv[2..-1] # remove -p
    
    set -l targets
    for pkg in $pkgs
        set -a targets "nixpkgs#$pkg"
    end
    
    command nix shell $targets
  else
    command nix-shell $argv # run the original
  end
end

set -U fish_greeting # disable greeting
fish_vi_key_bindings