{
  config,
  lib,
  pkgs,
  ...
}:
let
  customCfg = config.custom.system.services.openssh;
in
{
  config = lib.mkIf customCfg.enable {
    services.openssh.enable = true;

    services.openssh.settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      PermitTunnel = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      MaxAuthTries = 3;
      TCPKeepAlive = false;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;
      LogLevel = "VERBOSE";
    };

    preservation.preserveAt."/nix/persistence" = {
      files = [
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key.pub";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key.pub";
          how = "symlink";
          inInitrd = true;
          configureParent = true;
        }
      ];
    };
  };
}
