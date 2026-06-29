{ ... }: {
  flake.modules.nixos.dnsmasq = { ... }: {
    services.dnsmasq = {
      enable = true;
      settings = {
        interface = "labnet0";
        dhcp-range = "10.100.0.50,10.100.0.200,12h";
        
        # Forward *.lab.local queries -> DC01 
        server = [ "/lab.local/10.100.0.20" "192.168.1.1" ];
        
        # Static leases based on your IP architecture
        dhcp-host = [
          "srv01,10.100.0.10" 
          "dc01,10.100.0.20"
          "ws01,10.100.0.30"
        ];
      };
    };
  };
}