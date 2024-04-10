{
  pkgs,
  lib,
  config,
  ...
}: let
  ###############################################################################
  ################################# Android SDK #################################
  android-config = pkgs.androidenv.composeAndroidPackages {
    platformVersions = ["33"]; # API version 33
    includeEmulator = true;
    buildToolsVersions = ["33.0.0"];
    # Accept android sdk licenses:
    extraLicenses = [
      # Already accepted for you with the global accept_license = true or
      # licenseAccepted = true on androidenv.
      "android-sdk-license"

      # These aren't, but are useful for more uncommon setups.
      "android-sdk-preview-license"
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };
  #################################################################################
  ############################### Android Emulator ################################
  android-emulator = pkgs.androidenv.emulateApp {
    name = "emulate-MyAndroidApp";
    platformVersion = "33";
    abiVersion = "x86"; # armeabi-v7a, mips, x86_64
    systemImageType = "google_apis_playstore";
  };
in {
  options = {
    customized.android.enable = lib.mkEnableOption "Enable custom Android configuration";
  };

  config = lib.mkIf config.customized.android.enable {
    programs = {
      adb.enable = true; # Android Debug Bridge
    };

    environment.systemPackages = [
      android-config.androidsdk
      android-emulator
    ];
  };
}
