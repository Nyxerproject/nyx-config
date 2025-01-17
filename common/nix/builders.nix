{
  config,
  pkgs,
  ...
}: {
  nix = {
    buildMachines = [
      {
        # Will be used to call "ssh builder" to connect to the builder machine.
        # The details of the connection (user, port, url etc.)
        # are taken from your "~/.ssh/config" file.
        hostName = "bottom";
        # CPU architecture of the builder, and the operating system it runs.
        # Replace the line by the architecture of your builder, e.g.
        # - Normal Intel/AMD CPUs use "x86_64-linux"
        # - Raspberry Pi 4 and 5 use  "aarch64-linux"
        # - M1, M2, M3 ARM Macs use   "aarch64-darwin"
        # - Newer RISCV computers use "riscv64-linux"
        # See https://github.com/NixOS/nixpkgs/blob/nixos-unstable/lib/systems/flake-systems.nix
        # If your builder supports multiple architectures
        # (e.g. search for "binfmt" for emulation),
        # you can list them all, e.g. replace with
        # systems = ["x86_64-linux" "aarch64-linux" "riscv64-linux"];
        system = "x86_64-linux";
        # Nix custom ssh-variant that avoids lots of "trusted-users" settings pain
        protocol = "ssh-ng";
        # default is 1 but may keep the builder idle in between builds
        maxJobs = 3;
        # how fast is the builder compared to your local machine
        speedFactor = 3;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    # required, otherwise remote buildMachines above aren't used
    distributedBuilds = false;
    # optional, useful when the builder has a faster internet connection than yours
    settings = {
      builders-use-substitutes = true;
    };
  };
}
