{ ... }: {
  flake.modules.nixos."ad-lab" = { ... }: {
    # Declaratively generate the storage pool directories for libvirt
    systemd.tmpfiles.rules = [
      "d /var/lib/libvirt/images/ad 0755 root root -"
      "d /var/lib/libvirt/images/iso 0755 root root -"
    ];
  };
}