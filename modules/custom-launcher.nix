{...}: {
  # AFTER_INSTALL
  # - Create "Quick Service" running "customLauncher.sh" and add Cmd+Space shortcut to it
  # - Create "Quick Service" running Alacritty and add a shortcut for it ??
  # Second ToDo is because customLauncher.sh can't launch Alacritty

  home.file.customLauncher = {
    executable = true;
    target = ".config/scripts/customLauncher.sh";
    text = ''
      #!/bin/zsh

      ~/.config/scripts/popout.sh ~/.config/scripts/launcher.sh
      #osascript -e 'tell app "Terminal" to do script "~/.config/scripts/launcher.sh && exit"'
    '';
  };

  home.file.launcherPopoup = {
    executable = true;
    target = ".config/scripts/popoup.sh";
    text = ''
      #!/bin/zsh

      # Set terminal with "mylauncher" tytle as a floating window in Amethyst/Yabai
      alacritty -t "mylauncher" -o window.decorations=none --working-directory "$(pwd)" -e "$1"

    '';
  };

  home.file.launcherBehavior = {
    executable = true;
    target = ".config/scripts/launcher.sh";
    text = ''
      #!/bin/zsh

      find -L \
          ~/Applications/Home\ Manager\ Apps \
          /System/Library/CoreServices \
          /System/Applications /Applications \
          /System/Applications/Utilities \
          ~/Applications \
          -maxdepth 1 -name "*.app" | fzf | xargs -I {} open "{}"
    '';
  };
}
