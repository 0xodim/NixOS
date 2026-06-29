{ inputs, ... }: {
  flake.modules.nixos.nvidia = {
    # Enable the proprietary Nvidia drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.open = false;


    # Mandatory environment variables for Hyprland on Nvidia
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
