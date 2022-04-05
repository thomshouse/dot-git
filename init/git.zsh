#!/bin/zsh

git() {
  if [ "$1" = root ]; then
    builtin cd `git rev-parse --show-toplevel`
  else
    ISALIAS=$(command git --no-pager config --get-regexp "^alias\.$1\$");
    if [ -n "$ISALIAS" ]; then
	    ALIASARGS="";
	    for i in "${@:2}"; do
              ALIASARGS="$ALIASARGS $i";
	    done
	    ALIASOF="$(command git config alias.$1)";
	    if [[ "$ALIASOF" =~ "^!" ]]; then
	      ALIASOF="${ALIASOF#!}";
	    else
	      ALIASOF="git $ALIASOF";
	    fi;
	    dotfiles_git_verbalize "$ALIASOF$ALIASARGS";
    fi
    command git "$@"
  fi
}

dotfiles_git_verbalize() {
  echo "  \$ \e[1m\e[97m$@\e[0m";
}

# Aliases to git commands
alias g="git"
alias ga="dotfiles_git_verbalize git add && git add"
alias gb="dotfiles_git_verbalize git branch && git branch"
alias gcb="dotfiles_git_verbalize git checkout -b && git checkout -b"
alias gch="dotfiles_git_verbalize git checkout && git checkout"
alias gcm="dotfiles_git_verbalize git commit && git commit"
alias gd="dotfiles_git_verbalize git diff && git diff"
alias gf="dotfiles_git_verbalize git fetch && git fetch"
alias gff="dotfiles_git_verbalize git merge --ff-only && git merge --ff-only"
alias gm="dotfiles_git_verbalize git merge && git merge"
alias gp="dotfiles_git_verbalize git push && git push"
alias gr="dotfiles_git_verbalize git remote && git remote"
alias gs="dotfiles_git_verbalize git status && git status"
alias gup="dotfiles_git_verbalize git remote update -p && git remote update -p; dotfiles_git_verbalize git merge --ff-only @{u} && git merge --ff-only @{u}"

# Aliases to git aliases -- due to structure of commands
alias gffon="git ffon"
alias {gpu,gpushu}="git pushu"
