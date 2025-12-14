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
    inputs.agenix-rekey.nixosModules.default
    inputs.agenix.nixosModules.default
    inputs.nix-maid.nixosModules.default

    # Colmena
    {
      deployment.allowLocalDeployment = true;
      deployment.targetHost = null;
      deployment.tags = [ "workstation" ];
    }

    # NixOS modules
    (flakeRoot + /modules/system/bluetooth)
    (flakeRoot + /modules/system/container)
    (flakeRoot + /modules/system/dae)
    (flakeRoot + /modules/system/distrobox)
    (flakeRoot + /modules/system/fcitx5)
    (flakeRoot + /modules/system/firefox)
    (flakeRoot + /modules/system/font)
    (flakeRoot + /modules/system/networking)
    (flakeRoot + /modules/system/nix)
    (flakeRoot + /modules/system/pipewire)
    (flakeRoot + /modules/system/openssh)
    (flakeRoot + /modules/system/secret)
    (flakeRoot + /modules/system/waydroid)
    (flakeRoot + /modules/system/wireless)
    ./system/desktop.nix
    ./system/hardware.nix
    ./system/networking.nix
    ./system/system.nix

    # Home modules
    (
      { config, pkgs, ... }:
      {
        imports = [
          (flakeRoot + /modules/users/starryreverie/alacritty)
          (flakeRoot + /modules/users/starryreverie/atuin)
          (flakeRoot + /modules/users/starryreverie/bat)
          (flakeRoot + /modules/users/starryreverie/clipboard)
          (flakeRoot + /modules/users/starryreverie/difftastic)
          (flakeRoot + /modules/users/starryreverie/direnv)
          (flakeRoot + /modules/users/starryreverie/environment)
          (flakeRoot + /modules/users/starryreverie/eza)
          (flakeRoot + /modules/users/starryreverie/fastfetch)
          (flakeRoot + /modules/users/starryreverie/fd)
          (flakeRoot + /modules/users/starryreverie/fzf)
          (flakeRoot + /modules/users/starryreverie/git)
          (flakeRoot + /modules/users/starryreverie/github-copilot-cli)
          (flakeRoot + /modules/users/starryreverie/gtk-theme)
          (flakeRoot + /modules/users/starryreverie/helix)
          (flakeRoot + /modules/users/starryreverie/hyprlock)
          (flakeRoot + /modules/users/starryreverie/lazygit)
          (flakeRoot + /modules/users/starryreverie/niri-environment)
          (flakeRoot + /modules/users/starryreverie/qt-theme)
          (flakeRoot + /modules/users/starryreverie/ripgrep)
          (flakeRoot + /modules/users/starryreverie/rofi)
          (flakeRoot + /modules/users/starryreverie/swaync)
          (flakeRoot + /modules/users/starryreverie/vscode)
          (flakeRoot + /modules/users/starryreverie/waybar)
          (flakeRoot + /modules/users/starryreverie/wpaperd)
          (flakeRoot + /modules/users/starryreverie/xdg)
          (flakeRoot + /modules/users/starryreverie/yazi)
          (flakeRoot + /modules/users/starryreverie/zellij)
          (flakeRoot + /modules/users/starryreverie/zoxide)
          (flakeRoot + /modules/users/starryreverie/zsh)
          ./users/starryreverie/kanshi.nix
          ./users/starryreverie/niri-environment.nix
        ];
      }
    )
  ];
}
