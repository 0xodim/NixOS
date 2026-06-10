{ ... }: {
  # The Darwin Context (macOS-only feature)
  flake.modules.darwin.amethyst = { ... }: {
    homebrew.casks = [
      "amethyst"
      "raycast"
    ];
  };
}
