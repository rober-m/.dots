# Automatically set xrandr configs.
# NixOs autorandr package docs: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/misc/autorandr.nix#L295
# autorandr docs: https://github.com/phillipberndt/autorandr
# xrandr docs: man xrandr
{pkgs, ...}: {
  # If autorandr doesn't automatically change the config when plugging second monitor:
  services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

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
            # Scale everything by 1.5. INFO: >1 zooms OUT!  Use together with gtk 200% scaling.
            transform = [
              [1.500000 0.000000 0.000000]
              [0.000000 1.500000 0.000000]
              [0.000000 0.000000 1.000000]
            ];
          };
        };
      };
      "laptop+monitor" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5ca0b000000002f200104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a0073";
          DP-4 = "00ffffffffffff0006b368279494020011210104b53c22783b1c95a75549a2260f5054230800d1c0814081809500b30081c0010101014dd000a0f0703e803020350055502100001a000000fd00283ca0a03c010a202020202020000000fc004153555320504132373943560a000000ff0052344c4d54463136393130380a0109020333714f030201121113040f0e1e1d1f9060612309170783010000e2006a681a00000101283c00e305e301e606070161561ca36600a0f0701f803020350055502100001a565e00a0a0a029503020350055502100001a023a801871382d40582c450055502100001e4d6c80a070703e8030203a0055502100001a0000000074";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 1;
            primary = false;
            position = "0x0";
            mode = "2256x1504";
            rate = "60.00";
            transform = [
              [1.500000 0.000000 0.000000]
              [0.000000 1.500000 0.000000]
              [0.000000 0.000000 1.000000]
            ];
          };
          DP-4 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "3356x0"; # Figured this by trial and error
            mode = "3840x2160";
            rate = "60.00";
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
