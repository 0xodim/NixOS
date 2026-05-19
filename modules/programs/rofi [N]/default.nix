{ ... }: {
  # Define the Simple Aspect for the NixOS class
  flake.modules.nixos.rofi = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.rofi ];
  };
}
