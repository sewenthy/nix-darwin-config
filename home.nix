{ config, pkgs, lib, ... }:
let
  user = "user"; # change to your username
  # ZSH specific completion
  zshrcCompletionExtra = ''
    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  '';

  zshrcZoxideExtra = ''
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
  '';

in {
  home.username = user;
  home.homeDirectory = "/Users/${user}";

  home.stateVersion = "24.11";

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/starship.toml".source = ./starship.toml;
  };

  home = {
    shell = { enableZshIntegration = true; };

    shellAliases = {
      mk = "make";
      mw = "make watch";
      ll = "ls -lah";
      ls = "ls --color=auto";
      df = "df -h";
      free = "free -h";
      lsblk = "lsblk -io NAME,SIZE,TYPE,MOUNTPOINTS,LABEL,MODEL";
    };

  };

  programs = {
    home-manager.enable = true;

    kitty = {
      enable = true;
      themeFile = "tokyo_night_moon";
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      settings = {
        enable_audio_bell = false;
        font_size = 14;
        font_family = "FiraMono Nerd Font Mono";
        macos_option_as_alt = "both";
      };
    };

    zsh = {
      enable = true;

      autosuggestion = {
        enable = true;
        highlight = "fg=#4c566a,bg=#2e3440,bold";
      };

      antidote = {
        enable = true;
        plugins = [
          "Aloxaf/fzf-tab"
          # "tom-doerr/zsh_codex" # AI auto-completion

          ##### OMZ #####
          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:lib"
        ];
      };

      defaultKeymap = "emacs";

      enableCompletion = true;

      history = {
        append = true;
        findNoDups = true;
        ignoreDups = true;
        ignoreAllDups = true;
        save = 10000;
        saveNoDups = true;
        size = 10000;
        share = true;
      };

      # Add special handling in initExtra to ensure passage completion loads
      initExtra = lib.mkAfter ''
        ${zshrcCompletionExtra}
        ${zshrcZoxideExtra}
      '';

      syntaxHighlighting.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableTransience = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd" "cd" ];
    };
  };
}
