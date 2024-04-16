{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # IMPORTANT: Currently using non-nix installation because it's easier to keep udated and
  # dynamically modify settings (e.g., zoom in and out with `Ctrl+=`.)
  # Module: https://github.com/nix-community/home-manager/blob/ae631b0b20f06f7d239d160723d228891ddb2fe0/modules/programs/firefox.nix#L161
  # Config example: https://www.youtube.com/watch?v=GaM_paeX7TI
  # Final Firefox config at: ~/.mozilla/firefox/roberm/prefs.js  and ~/.mozilla/firefox/roberm/user.js
  options = {
    customized.firefox.enable = lib.mkEnableOption "Enable custom Firefox configuration";
    customized.firefox.withConfig = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Whether to include the custom Firefox configuration or just the firefox package.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (config.customized.firefox.enable && !config.customized.firefox.withConfig) {
      home.packages = with pkgs; [
        firefox
      ];
    })
    (lib.mkIf (config.customized.firefox.enable && config.customized.firefox.withConfig) {
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
            #tridactyl
          ];
        };
      };
    })
  ];
}
