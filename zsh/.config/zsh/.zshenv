# Prevent recursive sourcing
if [[ -z "$ZSHENV_SOURCED" ]]; then
  export ZSHENV_SOURCED=1

  export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
  [[ -f $ZDOTDIR/.zshenv && "$ZDOTDIR/.zshenv" != "$0" ]] && source $ZDOTDIR/.zshenv
fi
