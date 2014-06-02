#
case "${node[os]}" in
osx)
  profile=~/.bash_profile
;;
ubuntu|debian|centos|RHEL)
  profile=~/.bashrc
;;
*)
echo "not yet"; exit 1
;;
esac


block_append 'if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi' $profile

alias=~/.bash_aliases
[ -f $alias ] || touch $alias

#for git
block_append 'alias gs="git status "' $alias
block_append 'alias ga="git add "' $alias
block_append 'alias gc="git commit -a -m "' $alias
block_append 'alias gd="git diff "' $alias
block_append 'alias pull="git pull"' $alias
block_append 'alias push="git push"' $alias
block_append 'alias gl="git log --oneline"' $alias
