{lib, ...}: let
  manageDNSmanually = true;
in {
  networking = lib.mkMerge [
    {
      #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      networkmanager.enable = true; # Enable networking
      hostName = "framework"; # Define your hostname.
      enableIPv6 = false; # It might be causing "Host/Server Not Found" errors.
    }
    (lib.mkIf manageDNSmanually {
      networkmanager.dns = "none"; # Disable NetworkManager's internal DNS resolution
      useDHCP = false; # Use DHCP to get an IP address.
      dhcpcd.enable = false; # Disable dhcpcd.
      # Configure DNS manually here:
      nameservers = [
        "1.1.1.1" # Clodflare DNS
        "8.8.8.8" # Google Public DNS
      ];
    })
  ];
}
