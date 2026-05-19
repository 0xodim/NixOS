{ pkgs, ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.amd = {
    
    # 1. Update the AMD Ryzen CPU Microcode 
    hardware.cpu.amd.updateMicrocode = true;

    # 2. Enable OpenGL/Vulkan for your AMD GPU (Note: On NixOS 24.11+, hardware.opengl was renamed to hardware.graphics)
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true; # Useful if you plan to play Steam games!

    # 3. Tell the display server to explicitly load the 'amdgpu' driver
    services.xserver.videoDrivers = [ "amdgpu" ];
    
  };
}
