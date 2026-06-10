{ ... }: {
  
  flake.modules.nixos.thinkfan = { pkgs, ... }: {
    
    # Your requested Kernel and Initrd settings
    boot.kernelPackages = pkgs.linuxPackages_testing;
    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "battery" "thinkpad_acpi" ];

    # Allow the Linux kernel to control the ThinkPad fans
    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

    # Force modules to load early for sensor detection
    boot.kernelModules = [ "k10temp" "amdgpu" ];

    environment.systemPackages = [ pkgs.lm_sensors ];

    services.thinkfan = {
      enable = true;
      
      # Keep the persistent sensor config that solved our directory crashes!
      sensors = [
        {
          type = "hwmon";
          query = "/sys/class/hwmon";
          name = "k10temp";
          indices = [ 1 ]; 
        }
        {
          type = "hwmon";
          query = "/sys/class/hwmon";
          name = "amdgpu";
          indices = [ 1 ]; 
        }
      ];

      # Your requested levels translated into standard Nix array syntax
      levels = [
        [ 0  0  43 ]
        [ 1 35  45 ]
        [ 2 38  48 ]
        [ 3 42  53 ]
        [ 4 45  58 ]
        [ 5 48  62 ]
        [ 6 51  65 ]
        [ 7 54  68 ]
        ["level auto" 56 70]
        ["level full-speed" 58 999]
      ];
    };
  };
}
