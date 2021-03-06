#log multiline log
shopt -s cmdhist

#display date of history in ISO 8601
export HISTTIMEFORMAT="%FT%T%z "
#ignore ls, fg, bg, exit, history
export HISTIGNORE="&:ls:[bf]g:exit[ ]:history[ ]"

#change log file path if SSH_USER exists
if [[ "$SSH_USER" != "" && "$USER" != "" ]]; then
  readonly HISTFILE="/var/log/bash_history/${SSH_USER}_${USER}_history.log"
  [ ! -f $HISTFILE ] && touch $HISTFILE
elif [[ "$USER" != "" ]]; then
  readonly HISTFILE="/var/log/bash_history/system_${USER}_history.log"
  [ ! -f $HISTFILE ] && touch $HISTFILE
fi

#write to log, refresh
readonly PROMPT_COMMAND="history -a; history -c; history -r;$PROMPT_COMMAND"
