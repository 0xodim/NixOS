{ ... }: {
  
  # Define a Simple Aspect for the NixOS context [4, 5]
  flake.modules.nixos.thinkfan = { pkgs, ... }: {
    
    # Allow the Linux kernel to control the ThinkPad fans
    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

    # Ensure lm_sensors is installed for temperature reading
    environment.systemPackages = [ pkgs.lm_sensors ];

    services.thinkfan = {
      enable = true;
      
      # Map the hardware sensors
      sensors = [
        {
          type = "hwmon";
          # Replace X with your k10temp number (e.g., hwmon2)
          query = "/sys/class/hwmon/hwmonX/temp1_input"; 
        }
        {
          type = "hwmon";
          # Replace Y with your amdgpu number (e.g., hwmon3)
          query = "/sys/class/hwmon/hwmonY/temp1_input"; 
        }
      ];

      # Define your custom fan curve [fan_level, lower_temp, upper_temp]
      levels = [
        # Fan off below 45°C for silent operation
        # Level 1 (Low speed) between 40-55°C
        # Level 3 (Medium speed) between 50-65°C
        # Level 5 (High speed) between 60-75°C
        # Level 7 (Maximum manual speed) between 70-85°C
        ["level auto" 80 32767] # Hand control back to firmware for emergency max speed above 80°C
      ];
    };
  };
}
