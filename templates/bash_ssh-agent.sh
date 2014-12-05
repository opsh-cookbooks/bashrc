#!/bin/bash

load_ssh_keys() {
  for key in $@; do
    key_path=$(eval echo $key)
    [ ! -f $key_path ] && continue
    fingerprint=$(ssh-keygen -lf $key_path | cut -d " " -f 2)
    #echo $fingerprint
    ssh-add -l | grep " ${fingerprint} " &> /dev/null || ssh-add $key_path
  done
}

if [ -f ~/.bash_ssh-agent.txt ]; then
  load_ssh_keys $(cat ~/.bash_ssh-agent.txt | grep -v "^#")
fi
