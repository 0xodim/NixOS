{ inputs, ... }: {
  flake.modules.nixos.homelab = { ... }: {
    imports = [
      inputs.self.modules.nixos.virtualization
      inputs.self.modules.nixos."lab-network"
      inputs.self.modules.nixos.dnsmasq
      inputs.self.modules.nixos.wireguard
      inputs.self.modules.nixos."ad-lab"
    ];
  };
}