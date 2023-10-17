# Automatically set xrandr configs.
# NixOs autorandr package docs: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/misc/autorandr.nix#L295
# autorandr docs: https://github.com/phillipberndt/autorandr
# xrandr docs: man xrandr
{...}: {
  # If autorandr doesn't automatically change the config when plugging second monitor:
  #services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

  services.autorandr = {
    enable = true;

    profiles = {
      "laptop" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5ca0b000000002f200104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a0073";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2256x1504"; # "3384x2256";
            #gamma = "1.0:0.909:0.833"; # example
            rate = "60.00";
            #rotate = "left"; # example
            #dpi = 200;
            #scale = {
            #  x = 1.5;
            #  y = 1.5;
            #};
            # Scale everything by 1.5
            transform = [
              [1.500000 0.000000 0.000000]
              [0.000000 1.500000 0.000000]
              [0.000000 0.000000 1.000000]
            ];
          };
        };
      };
    };
  };
}
