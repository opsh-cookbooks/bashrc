if [ "$SSH_USER" != "" ]; then
  readonly HISTFILE="/var/log/bash_history/${SSH_USER}_history.log"
  [ ! -f $HISTFILE ] && touch $HISTFILE
  readonly PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
fi
