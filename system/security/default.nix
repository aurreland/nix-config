{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: {

  imports = [
    ./doas.nix
    ./network.nix
    ./firejail.nix
    ./gpg.nix
  ];
  
}
