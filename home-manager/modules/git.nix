{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Emil Andersson";
    userEmail = "eander0105@gmail.com";
    aliases = {
      st = "status";
      co = "checkout";
      com = "checkout master";
      cb = "checkout -b";
      last = "log -1 HEAD";
      up = "pull --rebase";
      unstage = "reset HEAD --";
      lg = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'";
      dc = "diff --cached";
      back = "reset --soft HEAD^";
      bsearch = "branch --all --list -i";
      alias = "! git config --get-regexp ^alias\\. | sed -e s/^alias\\.// -e s/\\ /\\ =\\ /";
    };
    extraConfig = {
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
      };
      pull = { rebase = true; };
      push = { autoSetupRemote = true; };
    };
  };
}
