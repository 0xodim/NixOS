{ ... }: {
  flake.modules.nixos.virtualization = { pkgs, ... }: {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu_kvm
      OVMFFull
      freerdp # Required for your xfreerdp connection strings to access Windows VMs!
    ];
  };
}
