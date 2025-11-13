{
  inputs,
  constants,
  flakeRoot,
  ...
}@args:
inputs.nixpkgs.lib.nixosSystem {
  inherit (constants) system;

  specialArgs = args;

  modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-maid.nixosModules.default
    (flakeRoot + /modules/nixos/starrynix-infrastructure/host)
    ./system.nix

    {
      home-manager.useUserPackages = true;
      home-manager.users.${constants.username} = import ./home.nix;
      home-manager.extraSpecialArgs = args;
      home-manager.backupFileExtension = "bak";
    }
  ];
}
