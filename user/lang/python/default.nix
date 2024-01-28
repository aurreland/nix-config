{ config, pkgs, ... }:

{

  imports = [
    ./packages.nix
  ];

  home.packages = with pkgs; [
      # Python setup
      python3Full
      imath
      pystring
  ];

}
