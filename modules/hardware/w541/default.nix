{ ... }: {
  # The Dendritic feature wrapper
  flake.modules.nixos.w541 = { ... }: {
    
    # --- Input Devices ---
    services.libinput.enable = true;

    # --- Intel i7-4810MQ CPU Management ---
    services.thermald.enable = true;
    services.tlp.enable = true;

    # --- Network & Bluetooth ---
    hardware.bluetooth.enable = true;
    networking.networkmanager.enable = true;

    # --- Nvidia Quadro K1100M ---
    # Note: verify these options against standard NixOS Nvidia docs
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false; 
    };
  };
}