{
  config,
  lib,
  pkgs,
  ...
}:
let
  batExecutable = lib.getExe config.programs.bat.package;
  fdExecutable = lib.getExe config.programs.fd.package;
  fzfExecutable = lib.getExe config.programs.fzf.package;
  ripgrepExecutable = lib.getExe config.programs.ripgrep.package;

  interactiveRipgrepScript = pkgs.writeScriptBin "rgi" ''
    RG_PREFIX="${ripgrepExecutable} --column --line-number --no-heading --color=always --smart-case "
    INITIAL_QUERY="''${*:-}"
    FZF_DEFAULT_COMMAND="if [[ -n \"$INITIAL_QUERY\" ]]; then; $RG_PREFIX $(printf %q \"$INITIAL_QUERY\"); fi || true" \
    ${fzfExecutable} --ansi \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.2; if [[ -n {q} ]]; then; $RG_PREFIX {q}; fi || true" \
        --bind="enter:execute($EDITOR {1} +{2})" \
        --delimiter=":" \
        --preview="if [[ -n {1} ]]; then; ${batExecutable} --style=numbers,header --color=always --highlight-line={2} {1}; fi" \
        --preview-window=border-left
  '';
in
{
  programs.fzf = {
    enable = true;

    defaultCommand = ''
      ${fdExecutable} --follow --color=always -E ".git" -E "build" -E "target" -E "node_modules" .
    '';

    defaultOptions = [
      "--ansi"
      "--reverse"
      "--scroll-off=5"
      "--cycle"
    ];
  };

  home.packages = [
    interactiveRipgrepScript
  ];

  programs.zsh.initContent = ''
    function _fzf_compgen_path() {
        eval "${fdExecutable} --follow --color=always -E '.git' -E 'build' -E 'target' -E 'node_modules' . \"$1\""
    }

    function _fzf_compgen_dir() {
        eval "${fdExecutable} --type d --follow --color=always -E '.git' -E 'build' -E 'target' -E 'node_modules' . \"$1\""
    }
  '';
}
