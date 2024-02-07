{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {

  security.doas.enable = true;
  security.sudo.enable = true;
  security.doas.wheelNeedsPassword = false;
  security.doas.extraRules = [{
    users = [ userSettings.username ];
    keepEnv = true;
    noPass = true;
  }];

  environment.shellAliases = {
    #sudo = "doas";
  };

}

