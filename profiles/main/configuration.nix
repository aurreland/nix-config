{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ../work/configuration.nix
    ../../system/games/gamemode.nix
    ../../system/games/steam.nix
    ../../system/games/star-citizen-fixes.nix
  ];

}
