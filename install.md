# Installation Guide

Start by cloning my repo :
```
git clone https://github.com/aurreland/nix-config/tree/master ~/.nix-config
```
Then copy your `hardware-configuration.nix` to `~/.nix-config/hosts/main/hardware-configuration.nix`. Additionally, you can create an other host directory or modify main.
```
sudo nixos-generate-config --show-hardware-config > ~/.nix-config/hosts/main/hardware-configuration.nix
```
You must then updates the settings inside `flake.nix` to suit your need.
Once everything is done, you can switch to the system configuration :
```
sudo nixos-rebuild switch --flake ~/.nix-config#system
```
Home-Manager can be installed with :
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
If home-Manager starts to not cooperate, it may be because the unstable branch of nixpkgs is in the Nix channel list. This can be fixed via:
```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```
Home-manager may also not work without re-logging back in after it has been installed. Once home-manager is running, my home-manager configuration can be installed with:
```
home-manager switch --flake ~/.nix-config#system
```
Then if you need to update, you can use the following commands :
```home-update``` for Home-Manager
```sys-update``` for Nixos
