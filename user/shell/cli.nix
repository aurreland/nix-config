{ config, lib, pkgs, ... }:

{
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    disfetch neofetch lolcat cowsay onefetch starfetch
    cava
    gnugrep gnused
    killall
    libnotify
    bat eza fd bottom ripgrep
    rsync
    tmux
    htop
    hwinfo
    most
    youtube-dl
    unzip
    pfetch
    octave
    brightnessctl
    uutils-coreutils-noprefix
    w3m
    fzf
    pandoc
    pciutils
    vim
    nix-doc
    tgpt
    (pkgs.callPackage ../../pkgs/pokemon-colorscripts.nix { })
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
          nmcli n on
      fi
    '')
  ];
}
