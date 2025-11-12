{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.fd.basePackage = pkgs.fd;

  wrappers.fd.prependFlags = [
    "--follow"

    "--exclude=**/node_modules/**"
    "--exclude=**/dist/**"
    "--exclude=**/{,_}build/**"
    "--exclude=**/target/**"
    "--exclude=**/{,.}venv/**"
    "--exclude=**/__pycache__/**"
    "--exclude=**/vendor/**"
    "--exclude=**/.gradle/**"
  ];
}
