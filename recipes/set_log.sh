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

template_cp "bash_setlog.sh" ~/.bash_setlog

#display date of history in ISO 8601
block_append 'export HISTTIMEFORMAT="%FT%T%z "' ~/.bashrc
block_append 'export HISTIGNORE="&:ls:[bf]g:exit"' ~/.bashrc

block_append '[ -f ~/.bash_setlog ] && . ~/.bash_setlog' ~/.bashrc
