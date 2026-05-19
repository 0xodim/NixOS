{ ... }: {
  # We pass pkgs into the aspect so we can install the package
  flake.modules.nixos.networkmanager = { pkgs, ... }: {
    networking.networkmanager.enable = true;
    
    # Explicitly install the package to guarantee nmtui is available globally
    environment.systemPackages = [
      
      pkgs.openvpn
      pkgs.networkmanager 
      pkgs.networkmanagerapplet
      pkgs.networkmanager-openvpn
      
    ];
  };
}
