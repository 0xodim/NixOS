{ ... }: {
  
  # The Simple Aspect (NixOS context)
  flake.modules.nixos.alsa = { pkgs, ... }: {
    
    # Install ALSA utilities system-wide
    environment.systemPackages = [ 
      pkgs.alsa-utils 
    ];

    # Run amixer automatically on boot to fix the microphone LED
    systemd.services.disable-auto-mute = {
      description = "Disable ALSA Auto-Mute Mode to fix mic LED";
      wantedBy = [ "multi-user.target" ];
      after = [ "sound.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.alsa-utils}/bin/amixer -c 1 sset 'Auto-Mute Mode' Disabled";
        RemainAfterExit = true;
      };
    };
  };
}
