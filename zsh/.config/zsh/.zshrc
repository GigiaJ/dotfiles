# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Zsh options
setopt autocd
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt share_history
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

setopt sharehistory
setopt extendedhistory

# superglobs
setopt extendedglob
unsetopt caseglob

# correct commands
setopt correct

# Tab completion from both ends
setopt completeinword
autoload -U compinit
compinit

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source ~/.config/zsh/.env

gitclone() {
  if [ -z "$1" ]; then
    echo "Usage: gitclone <github-repo-url>"
    return 1
  fi

  # Extract repo name from URL
  repo=$(basename "$1" .git)

  # Clone from GitHub
  git clone "$1"

  # === Create repo on Codeberg ===
  echo "📦 Creating '$repo' on Codeberg..."
  response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "https://$CODEBERG_HOST/api/v1/user/repos" \
    -H "Content-Type: application/json" \
    -H "Authorization: token $CODEBERG_ACCESS_TOKEN" \
    -d "{\"name\": \"$repo\", \"private\": false}")

  if [ "$response" = "201" ]; then
    echo "✅ Repo created on Codeberg."
  elif [ "$response" = "409" ]; then
    echo "⚠️ Repo already exists on Codeberg."
  else
    echo "❌ Failed to create repo on Codeberg. HTTP $response"
    return 1
  fi

  # === Create on Gitea ===
  echo "📦 Creating '$repo' on Gitea..."
  gitea_response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "https://gitea.$GITEA_HOST/api/v1/user/repos" \
    -H "Content-Type: application/json" \
    -H "Authorization: token $GITEA_ACCESS_TOKEN" \
    -d "{\"name\": \"$repo\", \"private\": false}")

  if [ "$gitea_response" = "201" ]; then
    echo "✅ Gitea repo created."
  elif [ "$gitea_response" = "409" ]; then
    echo "⚠️ Gitea repo already exists."
  else
    echo "❌ Gitea creation failed. HTTP $gitea_response"
    return 1
  fi

  # Add to Codeberg and Gitea
  cd "$repo" || return
  git remote set-url --add origin git@"$CODEBERG_HOST":"$CODEBERG_USER"/"$repo".git
  git remote set-url --add origin git@git."$GITEA_HOST":"$GITEA_USER"/"$repo".git

  echo "Cloned '$repo' and added Codeberg and Gitea remote."
}

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi