{inputs, ...}: {
  # TODO: Do full config based on: https://www.youtube.com/watch?v=GaM_paeX7TI
  programs.firefox = {
    enable = true;
    profiles.roberm = {
      # bookparks = [];
      # settings = {};
      # search.engines = {};

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        tridactyl
      ];
    };
  };
}
