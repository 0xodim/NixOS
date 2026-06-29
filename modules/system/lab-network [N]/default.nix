{ ... }: {
  flake.modules.nixos."lab-network" = { ... }: {
    boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
    
    networking = {
      bridges.labnet0.interfaces = [];
      interfaces.labnet0.ipv4.addresses = [{
        address = "10.100.0.1";
        prefixLength = 24;
      }];
      
      # NAT from labnet0 -> wlp2s0
      nat = {
        enable = true;
        internalInterfaces = [ "labnet0" ];
        externalInterface = "wlp2s0";
      };
    };
  };
}