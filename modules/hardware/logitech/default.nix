{ config, lib, pkgs, ... }: {
  flake.modules.nixos.logitech = {
    # This enables Solaar and installs the correct udev rules for Logitech receivers
    hardware.logitech.wireless.enable = true;
    
    # This ensures the Solaar GUI starts automatically and sits in your system tray
    hardware.logitech.wireless.enableGraphical = true;
  };
}