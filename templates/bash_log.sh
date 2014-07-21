if [ "$SSH_USER" != "" ]; then
  readonly HISTFILE="/var/log/history/${SSH_USER}_history.log"
  [ ! -f $HISTFILE ] && touch $HISTFIL
  readonly PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
fi
