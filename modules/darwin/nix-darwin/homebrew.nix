{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      #"yabai"

      # To build IHaskell from source
      "zeromq"
      "libmagic"
      "cairo"
      "pkg-config"
      #"haskell-stack"
      "pango"
      "zlib"
    ];
    taps = [
      "homebrew/cask"
      "koekeishiya/formulae" # yabai
      #"microsoft/git" # git-credential-manager-core
    ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
    casks = [
      "google-chrome"
      "telegram-desktop"
      "obs"
      "obsidian"
      "notion"
      "amethyst"
      #"git-credential-manager-core"
    ];
  };
}
