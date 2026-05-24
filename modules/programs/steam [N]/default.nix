{ ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.steam = { pkgs, ... }: {
    
    # This officially enables Steam and automatically handles all necessary 32-bit libraries,
    # FHS environments, and system-level dependencies.
    programs.steam = {
      enable = true;
      
      # Optional: Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true; 
      
      # Optional: Open ports in the firewall for Source Dedicated Servers
      dedicatedServer.openFirewall = true; 
    };

    # Optionally add steam-run to your environment so you have it for standalone games (like Factorio)
    environment.systemPackages = [ pkgs.steam-run ];
  };
}
