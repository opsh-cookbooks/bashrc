#

#1.
#PermitUserEnvironment yes

#2.
#After that you can configure your ~/.ssh/authorized_keys file:
#environment="SSH_USER=USER1" ssh-rsa AAAAfgds...
#environment="SSH_USER=USER2" ssh-rsa AAAAukde..


global="true"
log_path=/var/log/bash_history

#make sure enable environment
case "${node[os]}" in
osx)
  sshd_config="/etc/sshd_config";;
*)
  sshd_config="/etc/ssh/sshd_config";;
esac
  
if [ -f $sshd_config ]; then
  block_insert "PermitUserEnvironment yes" $sshd_config;
else
  echo "[warning] Can't set 'PermitUserEnvironment yes' in ssh config because it's missing"
fi

#prepare log directory
set_permission() {
  mkdir $log_path
  chmod 0757 $log_path
  chattr -R +a $log_path
}
[ ! -d $log_path ] && $sudo set_permission


if [ "$global" == "true" ]; then
    template_cp "bash_history.logrotate" /etc/logrotate.d/bash_history
    template_cp "bash_setlog.sh" /etc/bash.setlog
    block_append '[ -f /etc/bash.setlog ] && . /etc/bash.setlog' /etc/bash.bashrc
else
    echo "only use global"
    #template_cp "bash_setlog.sh" ~/.bash_setlog
    #block_append '[ -f ~/.bash_setlog ] && . ~/.bash_setlog' ~/.bashrc
fi
