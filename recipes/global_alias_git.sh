#alias
alias=/etc/bash.aliases
[ -f $alias ] || $sudo touch $alias

#which profile to use
profile=/etc/bash.bashrc


#use $alias
block_append "[ -f $alias ] && . $alias" $profile


#for git
block_append 'alias gs="git status"' $alias
block_append 'alias ga="git add"' $alias

block_append 'alias gc="git commit -a -m"' $alias
block_append 'alias gc-amend="git commit --amend"' $alias

block_append 'alias gd="git diff"' $alias
#same as gd HEAD@{1}
block_append 'alias gd-previous="git diff HEAD@{1}"' $alias

block_append 'alias pull="git pull"' $alias
block_append 'alias push="git push"' $alias

block_append 'alias gl="git log --oneline"' $alias
