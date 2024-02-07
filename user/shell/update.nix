{ pkgs, userSettings, ... }:

let

  updateScript = ''

    function user_update {
      echo -e "\033[0;34m### Syncing user configuration ###\033[0m"
      systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=16000M -p CPUQuota=60% home-manager switch --flake ''+userSettings.dotfilesDir+''#user --show-trace;
      eww reload
      swww img ''+userSettings.dotfilesDir+''/wallpaper
    }

    function system_update {
      echo -e "\033[0;34m### Syncing System configuration ###\033[0m"
      sudo systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild switch --flake ''+userSettings.dotfilesDir+''#system --show-trace;

    }

    if [ "$1" = "sync" ]; then
      if [ "$2" = "user" ]; then
        user_update;
      elif [ "$2" = "system" ]; then
        system_update;
      elif [ "$2" = "both" ]; then
        system_update;
        user_update;
      else
        echo "Please pass 'user', 'system' or 'both' arguments."
      fi
    elif [ "$1" = "update" ]; then
      update_flake;
    elif [ "$1" = "gc" ]; then
      if [ "$2" = "full" ]; then
        sudo nix-collect-garbage --delete-old;
        nix-collect-garbage --delete-old;
      elif [ "$2" ]; then
        sudo nix-collect-garbage --delete-older-than $2;
        nix-collect-garbage --delete-older-than $2;
      else
        sudo nix-collect-garbage --delete-older-than 30d;
        nix-collect-garbage --delete-older-than 30d;
      fi
    fi

  '';

in
{
  home.packages = [
    (pkgs.writeScriptBin "nix-update" updateScript)
  ];
}

