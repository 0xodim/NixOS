{ ... }: {
  # The Simple Aspect (NixOS context)
  flake.modules.nixos.bluetooth = { ... }: {
    
    # Enable Bluetooth support system-wide
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

  };
}
