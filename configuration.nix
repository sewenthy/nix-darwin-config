{ pkgs, config, inputs, ... }:
let
  user = "user"; # change to your username
  uid = 501; # check by running `id`
in {

  nix.enable = true;
  nix.gc = { automatic = true; };

  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages = with pkgs; [
    kitty
    nixfmt
    skhd
    starship
    yabai
    yazi
    zoxide
    zsh
  ];
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs = { zsh.enable = true; };

  fonts.packages = with pkgs; [ nerd-fonts.fira-mono ];

  users.users."${user}" = {
    shell = pkgs.zsh;
    home = "/Users/${user}";
    uid = uid; # check by running `id`
    openssh.authorizedKeys.keys = [ ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = { "${user}" = import ./home.nix; };
    sharedModules = [ inputs.mac-app-util.homeManagerModules.default ];
    backupFileExtension = ".bak";
  };

}
