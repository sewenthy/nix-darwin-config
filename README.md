# Nix Darwin + Home Manager

This setups kitty and zsh with a few other cosmetics.

## Installation

You can install nix-darwin at: https://github.com/LnL7/nix-darwin

Then you need to edit:

- `flake.nix` file to change the hostname to your own.
- `home.nix` and `configuration.nix` file to change the username to your own.

To switch to this configuration, run:
```bash
sudo nix --experimental-features 'nix-command flakes' run darwin-rebuild -- switch --flake .#minimal # or whatever your hostname is
```

After that, you can switch using darwin-rebuild:
```bash
sudo darwin-rebuild switch --flake .#minimal # or whatever your hostname is
```

## Further reading

A lot of configurations can be done with home manager: https://github.com/nix-community/home-manager





