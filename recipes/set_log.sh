#


#for current user



#1.
#PermitUserEnvironment yes

#2.
#After that you can configure your ~/.ssh/authorized_keys file:
#environment="SSH_USER=USER1" ssh-rsa AAAAfgds...
#environment="SSH_USER=USER2" ssh-rsa AAAAukde..

#prepare log directory

global=true
log_path=/var/log/bash_history

#make sure enable environment
block_insert "PermitUserEnvironment yes" /etc/ssh/sshd_config

#prepare log directory
set_permission() {
  mkdir $log_path
  chmod 0757 $log_path
  chattr -R +a $log_path
}
[ ! -d $log_path ] && $sudo set_permission


if [ "global" == "true" ]; then
    template_cp "bash_history.logrotate" /etc/logrotate.d/bash_history
    template_cp "bash_setlog.sh" /etc/bash.setlog
    block_append '[ -f /etc/bash.setlog ] && . /etc/bash.setlog' /etc/bash.bashrc
else
    echo "only use global"
    #template_cp "bash_setlog.sh" ~/.bash_setlog
    #block_append '[ -f ~/.bash_setlog ] && . ~/.bash_setlog' ~/.bashrc
fi
