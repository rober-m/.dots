{
  inputs,
  pkgs,
  ...
}: {
  # Module: https://github.com/nix-community/home-manager/blob/ae631b0b20f06f7d239d160723d228891ddb2fe0/modules/programs/firefox.nix#L161
  # Config example: https://www.youtube.com/watch?v=GaM_paeX7TI
  # Final Firefox config at: ~/.mozilla/firefox/roberm/prefs.js  and ~/.mozilla/firefox/roberm/user.js
  programs.firefox = {
    enable = true;
    profiles.roberm = {
      # bookmarks = [];
      settings = {
        "dom.security.https_only_mode" = true;
        #"font.name.serif.x-western" = "FiraCode Nerd Font Mono";
        "font.size.variable.x-western" = 14;
      };
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nix"];
          };
        };
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        tridactyl
      ];
    };
  };
}
