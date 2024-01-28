{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      shell fish
    '';
  };  
}