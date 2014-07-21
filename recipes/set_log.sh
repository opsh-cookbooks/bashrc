#


#for current user



#1.
#PermitUserEnvironment yes

#2.
#After that you can configure your ~/.ssh/authorized_keys file:
#environment="SSH_USER=USER1" ssh-rsa AAAAfgds...
#environment="SSH_USER=USER2" ssh-rsa AAAAukde..


#prepare log directory

$sudo block_insert "PermitUserEnvironment yes" /etc/ssh/sshd_config

log_path=/var/log/bash_history
set_permission() {
  mkdir $log_path
  chmod 0777 $log_path
  chattr -R +a $log_path
}
[ ! -d $log_path ] && $sudo set_permission

#todo: check exist and permission

template_cp "bash_log.sh" ~/.bash_log
block_append "[ -f ~/.bash_log ] && . ~/.bash_log" ~/.bashrc
