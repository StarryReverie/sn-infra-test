{
  config,
  lib,
  pkgs,
  inputs,
  constants,
  flakeRoot,
  ...
}:
let
  systemModuleRoot = flakeRoot + /modules/system;
in
{
  imports = [
    # Common system modules
    (systemModuleRoot + /dae)
    (systemModuleRoot + /networking)
    (systemModuleRoot + /nix)
    (systemModuleRoot + /openssh)
    (systemModuleRoot + /secret)
    (systemModuleRoot + /wireless)

    # Host-specific system modules
    ./hardware.nix
    ./networking.nix
    ./service.nix
  ];

  networking.hostName = constants.hostname;
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1iflX8DYwoguHB2BDxLy+eAcdBX+gTHEGqGNBFdvs/";

  system.stateVersion = "25.11";
}
