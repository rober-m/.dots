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

  services.xremap = {
    withHypr = true; # Work with Hyprlnd
    userName = user-options.username;
    #yamlConfig = builtins.readFile ./xremap.yml;
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
      ];
    };
  };
}
