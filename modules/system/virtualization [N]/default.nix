{ ... }: {
  flake.modules.nixos.virtualization = { pkgs, ... }: {
    
    # 1. Enable libvirt and deeply configure QEMU
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_full; # Full architecture support (includes OVMF natively now)
        runAsRoot = true;
        
        # Enable Software TPM 2.0 emulator (Required for Windows 11)
        swtpm.enable = true;
        
        # NOTE: The 'ovmf' block was completely removed here!
      };
    };

    # 2. Enable virt-manager GUI and its required security policies
    programs.virt-manager.enable = true;
  
    # 3. Add strictly client-side connection tools to system packages
    environment.systemPackages = with pkgs; [
      virt-viewer # For your SPICE/VNC console connections to the malware lab
      freerdp     # Required for your xfreerdp connection strings to access AD Windows VMs!
    ];
  };
}