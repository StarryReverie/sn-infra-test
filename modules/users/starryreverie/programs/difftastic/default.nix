{
  config,
  lib,
  pkgs,
  ...
}:
{
  custom.users.starryreverie = {
    applications.git = {
      config =
        let
          difftasticExecutable = lib.getExe pkgs.difftastic;
        in
        {
          diff = {
            external = difftasticExecutable;
            tool = "difftastic";
          };

          difftool."difftastic" = {
            cmd = "${difftasticExecutable} $LOCAL $REMOTE";
          };
        };
    };
  };

  users.users.starryreverie = {
    maid = {
      packages = with pkgs; [ difftastic ];
    };
  };
}
