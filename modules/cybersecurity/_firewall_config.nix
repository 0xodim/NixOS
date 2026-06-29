{ ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.cybersecurity = { pkgs, ... }: {
 
    # System-level Firewall Configuration
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ]; 
      allowedUDPPorts = [ ]; 
      pingLimit = "--limit 1/minute --limit-burst 5";
    };

    services.fail2ban.enable = true;

    environment.systemPackages = [
      pkgs.iptables
      pkgs.fail2ban
    ];
  };
}