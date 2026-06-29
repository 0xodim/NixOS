{ inputs, ... }: {
  imports = [
    ./_firewall_config.nix  
  ];

  # 1. The Auxiliary Module (Home Manager context)
  # Put your basic tool installations directly here!
  flake.modules.homeManager.cybersecurity = { pkgs, ... }: {
    home.packages = with pkgs; [
      nmap
      wireshark
      tcpdump
      metasploit
      hashcat
    ];
  };

  # 2. The Main Module (NixOS context)
  # Automatically inject the Home Manager tools into the NixOS system
  flake.modules.nixos.cybersecurity = { ... }: {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.cybersecurity ];
  };
}