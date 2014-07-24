#

#for current user or other user
if [[ "$user" != "" && "$user" != "$USER" ]]; then
  homepath=$(eval echo ~$user)
else
  homepath=~
fi

ps_file="${homepath}/.bash_ps"
[ -f ${ps_file} ] || touch ${ps_file}

if [[ "${homepath}" != ~ ]]; then
  chown ${user}:${user} ${ps_file}
fi

#which profile to use
case "${node[os]}" in
osx)
  profile=${homepath}/.bash_profile
  template_cp "bash_ps.osx.sh" ${ps_file}
;;
ubuntu|debian|centos|RHEL)
  profile=${homepath}/.bashrc
  template_cp "bash_ps.sh" ${ps_file}
;;
*)
echo "not yet"; exit 1
;;
esac

block_append '[ -f ~/.bash_ps ] && . ~/.bash_ps' $profile

