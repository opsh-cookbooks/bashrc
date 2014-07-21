#

#for current user or other user
if [[ "$user" != "" && "$user" != "$USER" ]]; then
  homepath=$(eval echo ~$user)
else
  homepath=~
fi
 
#make sure .bash_alias exists and in right permission
alias=${homepath}/.bash_aliases
[ -f $alias ] || $sudo touch $alias

if [[ "${homepath}" != ~ ]]; then
  $sudo chown ${user}:${user} $alias
fi


#which profile to use
case "${node[os]}" in
osx)
  profile=${homepath}/.bash_profile
;;
ubuntu|debian|centos|RHEL)
  profile=${homepath}/.bashrc
;;
*)
echo "not yet"; exit 1
;;
esac


#use ~/.bash_alias
block_append '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' $profile


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
