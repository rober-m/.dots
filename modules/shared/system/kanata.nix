{
  lib,
  pkgs,
  config,
  ...
}: {
  # Custom option config to enable tmux with some plugins.
  options = {
    customized.kanata.enable =
      lib.mkEnableOption "Enable kanata (keyboard layout) with personal config";
  };

  config =
    lib.mkIf (config.customized.kanata.enable
      && pkgs.stdenv.hostPlatform.isLinux) {
      services.kanata = {
        enable = true;
        keyboards = {
          internalKeyboard = {
            extraDefCfg = "process-unmapped-keys yes";
            config = builtins.readFile ./kanata.kbd;
          };
        };
      };
    }
    // lib.mkIf (config.customized.kanata.enable
      && pkgs.stdenv.hostPlatform.isDarwin) {
      home.packages = with pkgs; [
        kanata # Keyboard remap layouts.
        #(callPackage ../../../my-pkgs/my-kanata.nix {}) # The installer works, but kanata doesn't. TODO: Create an issue.
      ];
      home.file.".config/kanata/kanata.kbd".text =
        /*
        lisp
        */
        ''
          ;; defsrc is still necessary
          (defcfg
            process-unmapped-keys yes
          )

          (defsrc
            a s d f j k l ;
          )
          (defvar
            tap-time 150
            hold-time 200
          )

          (defalias
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lsft)
            f (tap-hold $tap-time $hold-time f lctl)
            j (tap-hold $tap-time $hold-time j rctl)
            k (tap-hold $tap-time $hold-time k rsft)
            l (tap-hold $tap-time $hold-time l ralt)
            ; (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
            @a @s @d @f @j @k @l @;
          )
        '';
    };
}
