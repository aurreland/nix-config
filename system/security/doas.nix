{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: {

  security.doas.enable = true;
  security.sudo.enable = true;
  security.doas.wheelNeedsPassword = false;
  security.doas.extraRules = [{
    users = [ username ];
    keepEnv = true;
    noPass = true;
  }];

  environment.shellAliases = {
    #sudo = "doas";
  };
 
}
  
