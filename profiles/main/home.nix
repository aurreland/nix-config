{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ../work/home.nix
    ../../user/games/lutris.nix
    ../../user/games/heroic.nix
    ../../user/games/steam.nix
    ../../user/games/star-citizen.nix
  ];

}
