{
  inputs,
  constants,
  flakeRoot,
  ...
}@specialArgs:
inputs.nixpkgs.lib.nixosSystem {
  inherit (constants) system;
  inherit specialArgs;

  extraModules = [
    inputs.colmena.nixosModules.deploymentOptions
  ];

  modules = [
    # External modules
    inputs.nix-maid.nixosModules.default

    # Colmena
    {
      deployment.allowLocalDeployment = true;
      deployment.buildOnTarget = true;
      deployment.targetHost = "${constants.hostname}.tail931dca.ts.net";
      deployment.tags = [ "server" ];
    }

    # StarryNix-Infrastructure
    (flakeRoot + /modules/system/starrynix-infrastructure/host)
    (flakeRoot + /nodes/registry.nix)

    # NixOS modules
    (flakeRoot + /modules/system/dae)
    (flakeRoot + /modules/system/networking)
    (flakeRoot + /modules/system/nix)
    (flakeRoot + /modules/system/openssh)
    (flakeRoot + /modules/system/secret)
    (flakeRoot + /modules/system/wireless)
    ./system/hardware.nix
    ./system/networking.nix
    ./system/service.nix
    ./system/system.nix

    # Home modules
    (
      { config, pkgs, ... }:
      {
        imports = [
          (flakeRoot + /modules/users/starryreverie/atuin)
          (flakeRoot + /modules/users/starryreverie/bat)
          (flakeRoot + /modules/users/starryreverie/difftastic)
          (flakeRoot + /modules/users/starryreverie/direnv)
          (flakeRoot + /modules/users/starryreverie/environment)
          (flakeRoot + /modules/users/starryreverie/eza)
          (flakeRoot + /modules/users/starryreverie/fastfetch)
          (flakeRoot + /modules/users/starryreverie/fd)
          (flakeRoot + /modules/users/starryreverie/fzf)
          (flakeRoot + /modules/users/starryreverie/git)
          (flakeRoot + /modules/users/starryreverie/helix)
          (flakeRoot + /modules/users/starryreverie/lazygit)
          (flakeRoot + /modules/users/starryreverie/ripgrep)
          (flakeRoot + /modules/users/starryreverie/yazi)
          (flakeRoot + /modules/users/starryreverie/zellij)
          (flakeRoot + /modules/users/starryreverie/zoxide)
          (flakeRoot + /modules/users/starryreverie/zsh)
        ];
      }
    )
  ];
}
