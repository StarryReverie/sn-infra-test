{ inputs, serviceConstants, ... }@args:
{
  inherit (serviceConstants) system;

  specialArgs = args;

  config = {
    imports = [
      inputs.microvm.nixosModules.microvm
      ./service.nix
      ./microvm.nix
    ];
  };
}
