{
  lib,
  config,
  pkgs,
  user-options,
  ...
}: let
  onlyLinuxAttr = lib.attrsets.optionalAttrs pkgs.stdenv.hostPlatform.isLinux;
  onlyDarwinAttr = lib.attrsets.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin;
in {
  options = {
    customized.zsh.enable = lib.mkEnableOption "Enable custom zsh configuration";
  };
  config = lib.mkIf config.customized.zsh.enable {
    #home.packages = with pkgs; [
    #  spaceship-prompt # Docs: https://spaceship-prompt.sh/config/intro/
    #];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      dotDir = ".config/zsh";

      oh-my-zsh = {
        enable = true;
        plugins =
          [
            #"git" # DOCS: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
            "vi-mode" # DOCS: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
          ]
          ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
            # I use this only on linux. Mac doesn't need it.
            "ssh-agent" # DOCS: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
          ];
        theme = "robbyrussell"; # This is not only colors, but also prompt config.
      };

      dirHashes = {
        # iog = "$HOME/IOG";
        # hc = "$HOME/IOG/haskell-course";
        # pr = "$HOME/Projects";
        # sc = "$HOME/scratchpad";
      };
      # localVariables = {};
      shellAliases =
        {
          ls = "lsd";
          ll = "lsd -l";
          la = "lsd -la";
          v = "nvim";
          cat = "bat";
          e = "exit";
          c = "clear";
          bw = "NODE_OPTIONS=\"--no-deprecation\" bw"; # See: https://github.com/bitwarden/clients/issues/6689

          # Git-related
          gs = "git status";
          gaa = "git add --all";
          gcm = "git commit -m";
          gca = "git commit --amend --no-edit";
          gch = "git checkout";
          gp = "git pull";
          gP = "git push";
          lg = "lazygit";
          lzd = "lazydocker";

          # Quick movement
          dots = "cd ~/.dots && nvim ."; # cd before so nvim plugis work properly
          scr = "cd ~/scratchpad";
          pro = "cd ~/projects";
          iog = "cd ~/IOG";
          exer = "cd ~/projects/100-exercises-to-learn-rust/exercises/ && wr";

          # Nix-related
          # add "--refresh" to any "nix develop" command that you want to update inputs
          h810 = "nix develop github:input-output-hk/devx#ghc810 --no-write-lock-file";
          h92 = "nix develop github:input-output-hk/devx#ghc92 --no-write-lock-file";
          h94 = "nix develop github:input-output-hk/devx#ghc94 --no-write-lock-file";
          h96 = "nix develop github:input-output-hk/devx#ghc96 --no-write-lock-file";
          h810-iog = "nix develop github:input-output-hk/devx#ghc810-iog --no-write-lock-file";
          h92-iog = "nix develop github:input-output-hk/devx#ghc92-iog --no-write-lock-file";
          h94-iog = "nix develop github:input-output-hk/devx#ghc94-iog --no-write-lock-file";
          h96-iog = "nix develop github:input-output-hk/devx#ghc96-iog --no-write-lock-file";
          plutus-apps12 = "nix develop github:input-output-hk/plutus-apps/v1.2.0";
        }
        // onlyLinuxAttr {
          rebuild = "sudo nixos-rebuild switch --flake ~/.dots#framework";
          collect-garbage = "sudo nix-collect-garbage --delete-older-than 7d";
          open = "xdg-open"; # Open files with default application
        }
        // onlyDarwinAttr {
          rebuild = "darwin-rebuild switch --flake ~/.dots#macbook";
          collect-garbage = "echo 'TODO: Implement collect-garbage in Darwin'";
        };

      # Multi-platform extra commands that should be added to {file}`.zshrc`.
      # MacOS and Linux-specific commands are provided in the respective sections.
      initExtra =
        /*
        bash
        */
        ''
          # Aiken-specific configuration
          # If aiken binary is present in nix-profile, add completion
          if [[ -f "/Users/${user-options.username}/.nix-profile/bin/aiken" ]]; then
              if [[ -f "/Users/${user-options.username}/.nix-profile/share/zsh/site-functions/_aiken" ]]; then
                  source /Users/${user-options.username}/.nix-profile/share/zsh/site-functions/_aiken
              else
                aiken completion zsh > /Users/${user-options.username}/.nix-profile/share/zsh/site-functions/_aiken
                source /Users/${user-options.username}/.nix-profile/share/zsh/site-functions/_aiken
              fi
          fi
          # If aiken binary is present in .aiken/bin, add to PATH and add completion
          export PATH=$HOME/.aiken/bin:$PATH

          # Add Yaci-Devkit to path
          export PATH="$HOME/.yaci-devkit/bin:$PATH"
          #if [[ -f "/Users/${user-options.username}/.yaci-devkit/bin" ]]; then
          #  export PATH="$HOME/.yaci-devkit/bin:$PATH"
          #fi

          # Add Dart to path
          export PATH=$HOME/.pub-cache/bin:$PATH

          # Initialize zoxide (z)
          eval "$(zoxide init --cmd cd zsh)"

          #Print neofetch
          #neofetch

          # INFO: Comented out to try zellij, but it works properly
          # Start tmux session if not in one
          #if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]]; then
          #  tmux new-session -A -s main
          #fi

          # Autostart zellij (see: https://github.com/zellij-org/zellij/blob/3dda02f44e06a5137da6139492997e0a77a757c1/zellij-utils/assets/shell/auto-start.zsh)
          if [[ -z "$ZELLIJ" ]]; then
             if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
                 zellij attach -c
             else
                 zellij
             fi

             if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
                 exit
             fi
          fi

          # Add Rust binaries to PATH
          export PATH=$HOME/.cargo/bin:$PATH

          # Add NPM executables to PATH so that they are available as commands:
          #(to use this, run `npm config set prefix '~/.mutable_node_modules'`)
          export PATH="$HOME/.mutable_node_modules/bin:$PATH"

          # Set up fzf key bindings and fuzzy completion
          source <(fzf --zsh)
          # Add default fzf command
          export FZF_DEFAULT_COMMAND='fd --exclude node_modules --exclude .git --exclude dist-newstyle'
          # Search files with fzf (ENTER to print path, CTRL-O to open with nvim)
          sf() {
            fzf --height 40% --preview "bat --color=always --line-range :500 {}" --preview-window=right:70% --bind "ctrl-o:become(nvim {}),enter:become(readlink -f {})"
          }
          # Searching file contents with ripgrep combined with fzf preview
          # search-text - usage: sf <searchTerm>
          st() {
            if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
            rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
          }

          # Spaceship prompt is too slow! Disabling it for now
          #source "${pkgs.spaceship-prompt}/lib/spaceship-prompt/spaceship.zsh"
          #export SPACESHIP_PROMPT_ASYNC=false # https://github.com/spaceship-prompt/spaceship-prompt/issues/1193
        ''
        + lib.optionalString pkgs.stdenv.hostPlatform.isLinux
        /*
        bash
        */
        ''
          # Linux-specific ZSH configuration
          export PATH=$HOME/.local/bin/:$PATH
          #weather-cli -l 38 -g 9

          # Flutter can't find chrome on linux
          export CHROME_EXECUTABLE=google-chrome-stable
        ''
        + lib.optionalString pkgs.stdenv.hostPlatform.isDarwin
        /*
        bash
        */
        ''
          # MacOS-specific ZSH configuration
          eval "$(/opt/homebrew/bin/brew shellenv)" # Needed for homebrew

          export PATH=$HOME/.cabal/bin/:$PATH # Add cabal-installed binaries to PATH
          #weather-cli -l 38 -g 9

          export ANDROID_HOME=$HOME/Library/Android/sdk
          export PATH=$PATH:$ANDROID_HOME/emulator
          export PATH=$PATH:$ANDROID_HOME/platform-tools
        '';
      profileExtra = ''
        # export KEYTIMEOUT=1 # Needed for ZSH vi mode
      '';

      sessionVariables =
        {
          IHP_EDITOR = "code --goto";
          ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#888"; # Change autosuggest highligh color
          VI_MODE_RESET_PROMPT_ON_MODE_CHANGE = true; # For oh-my-zsh vi-mode
        }
        // onlyLinuxAttr {
          #CHROME_EXECUTABLE = "google-chrome-stable"; # Flutter can't find chrome on linux
        }
        // onlyDarwinAttr {
          HOMEBREW_NO_ANALYTICS = 1;
        };
    };
  };
}
