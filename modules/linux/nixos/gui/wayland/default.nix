{
  pkgs,
  imports,
  ...
}: {
  # TODO: Can I move this config to home manager? (non-nix config files already are)
  programs.hyprland = {
    enable = true; # Doesn't work on NVIDIA
    xwayland.enable = true; # To run X11 apps
  };

  environment.systemPackages = with pkgs; [
    waybar # Status bar (other options: polybar, eww)
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))

    dunst # Notification daemon
    libnotify # (required by dunst)

    swww # Wallpaper deamon

    rofi-wayland # Application launcher

    networkmanagerapplet # Network manager menu in the status bar
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enable Ozone-Wayland for Chromium and Electron apps
  };

  xdg.portal.enable = true; # For aps to comunicate
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # imports.imports.home.file.".config/rofi/config.rasi".source = ./modules/gui/wayland/config.rasi;
  # imports.home.file.".config/hypr/hyprland.conf".source = ./modules/gui/wayland/hyprland/hyprland.conf;
  # imports.home.file.".config/hypr/start.sh" = {
  #   source = ./modules/gui/wayland/hyprland/start.sh;
  #   executable = true;
  # };
}
