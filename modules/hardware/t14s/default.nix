{ ... }: {
  # The Dendritic feature wrapper for your T14s
  flake.modules.nixos.t14s = { pkgs, ... }: {
    
    # --- Input Devices, Network & Power ---
    services.libinput.enable = true;
    hardware.bluetooth.enable = true;
    networking.networkmanager.enable = true;


    # --- AMD Ryzen CPU & Integrated Graphics ---
    hardware.cpu.amd.updateMicrocode = true;
    
    # Enable OpenGL/Vulkan for your AMD GPU 
    # (Note: On NixOS 24.11+, hardware.opengl was renamed to hardware.graphics)
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true; 
    
    # Tell the display server to explicitly load the 'amdgpu' driver
    services.xserver.videoDrivers = [ "amdgpu" ];

    # --- Boot & Kernel Settings ---
    boot.kernelPackages = pkgs.linuxPackages_testing;
    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "battery" "thinkpad_acpi" ];
    
    # Force modules to load early for sensor detection
    boot.kernelModules = [ "k10temp" "amdgpu" ];

    # Allow the Linux kernel to control the ThinkPad fans
    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

    # --- ThinkFan & Thermals ---
    environment.systemPackages = [ pkgs.lm_sensors ];
    
    services.thinkfan = {
      enable = true;
      
      # Keep the persistent sensor config
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

      # Requested levels
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