{...}:{

  networking = {

    networkmanager.enable = true; # Enable networking
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    hostName = "framework"; # Define your hostname.
    enableIPv6 = false; # It might be causing "Host/Server Not Found" errors.
    nameservers = [ "1.1.1.1"]; # 1.1.1.1 is Clodflare DNS. 8.8.8.8 is Google Public DNS.
  };

}
