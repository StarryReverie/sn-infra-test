{
  config,
  lib,
  pkgs,
  constants,
  ...
}:
{
  users.users.${constants.username} = {
    maid = {
      packages = with pkgs; [ difftastic ];
    };

    custom.git = {
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
}
