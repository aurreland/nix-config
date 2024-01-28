{ config, pkgs, ... }:
let
  # My shell aliases
  myAliases = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    mn = "PAGER=most man";
    #sudo = "doas";
    fetch = "disfetch";
    gitfetch = "onefetch";
    home-update = "home-manager switch --flake ~/.nix-config#user";
    sys-update = "sudo nixos-rebuild switch --flake ~/.nix-config#system";
  };
in
{

  imports = [
    ./cli.nix
  ];

  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    interactiveShellInit = ''
      function fish_greeting
        pokemon-colorscripts --no-title -n wingull
      end
      set PAGER "most"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    disfetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd bc
    direnv nix-direnv
  ];

  #programs.direnv.enable = true;
  #programs.direnv.enableFishIntegration = true;
  #programs.direnv.nix-direnv.enable = true;
}