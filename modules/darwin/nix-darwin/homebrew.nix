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
      "aikup"
    ];
    taps = [
      "homebrew/cask"
      "koekeishiya/formulae" # yabai
      "aiken-lang/homebrew-tap"
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
