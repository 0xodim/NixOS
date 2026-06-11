{ ... }: {
  flake.modules.nixos.nasm = { pkgs, ... }: {
    environment.systemPackages = [ 
      pkgs.nasm 
    ];
  };
}
