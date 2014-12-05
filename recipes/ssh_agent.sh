#

#for current user or other user
if [[ "$user" != "" && "$user" != "$USER" ]]; then
  homepath=$(eval echo ~$user)
else
  homepath=~
fi

bash_ext_file="${homepath}/.bash_ssh-agent"
[ -f ${bash_ext_file} ] || touch ${bash_ext_file}

if [[ "${homepath}" != ~ ]]; then
  chown ${user}:${user} ${bash_ext_file}
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

template_cp "bash_ssh-agent.sh" ${bash_ext_file}
[ -f ${homepath}/.bash_ssh-agent.txt ] || touch ${homepath}/.bash_ssh-agent.txt

block_append '[ -f ~/.bash_ssh-agent ] && . ~/.bash_ssh-agent' $profile


