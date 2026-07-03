{ pkgs, ... }: {
  flake.modules.nixos.sunshine = { ... }: {
    # Enable the Sunshine streaming service
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true; # Required for Wayland capture
      openFirewall = true; # Automatically opens ports for Moonlight
    };
  };
}