{
  user-options,
  inputs,
  ...
}: {
  imports = [
    inputs.xremap-flake.nixosModules.default
  ];

  hardware.uinput.enable = true;
  users.groups.uinput.members = [user-options.username];
  users.groups.input.members = [user-options.username];

  #---------------------------------------------------------
  # WARNING!!!: For this to work on the Moonlander, make
  # sure to plug it in AFTER booting the system or re-plug.
  # Else, this will conflict with the Moonlander's config!!
  #---------------------------------------------------------

  services.xremap = {
    #withHypr = true; # Work with Hyprlnd
    withWlroots = true; # Work with Wayland
    userName = user-options.username;
    #yamlConfig = builtins.readFile ./xremap.yml;
    # DOCS: https://github.com/k0kubun/xremap
    # Key names: https://github.com/emberian/evdev/blob/1d020f11b283b0648427a2844b6b980f1a268221/src/scancodes.rs#L26-L572
    config = {
      modmap = [
        {
          name = "Swap Esc";
          remap = {
            "ESC" = "CapsLock";
            "CapsLock" = "ESC";
          };
        }
        {
          name = "Super grave accent (`)";
          remap = {
            Grave = {
              alone = "Grave";
              held = "Super_L";
            };
          };
        }
        {
          name = "Super backslash (\)";
          remap = {
            Backslash = {
              alone = "Backslash";
              held = "Super_L";
            };
          };
        }
      ];
    };
  };
}
