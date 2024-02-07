{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    ./doas.nix
    ./network.nix
    ./firejail.nix
    ./gpg.nix
  ];

}
