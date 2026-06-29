{ ... }: {
  flake.modules.nixos.wireguard = { ... }: {
    networking.wireguard.interfaces.wg0 = {
      ips = [ "10.99.0.1/24" ];
      listenPort = 51820; # Defined in your Port Map
      privateKeyFile = "/etc/wireguard/private.key";
    };
    networking.firewall.allowedUDPPorts = [ 51820 ];
  };
}