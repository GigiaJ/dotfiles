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

dotfile() {
  repo_dir="$HOME/.git"
  file="$2"

  case "$1" in
    add)
      if [ -z "$file" ]; then echo "Usage: dotfile add <file>"; return 1; fi
      if [ ! -e "$HOME/$file" ]; then echo "File does not exist: $file"; return 1; fi

      if ! grep -Fxq "!$file" "$HOME/.gitignore"; then
        echo -e "\n!$file" >> "$HOME/.gitignore"
	      git --git-dir="$repo_dir" --work-tree="$HOME" add .gitignore
        echo "Added '!$file' to .gitignore"
      fi
      git --git-dir="$repo_dir" --work-tree="$HOME" add "$file"
      echo "Added $file to dotfiles repo"
      ;;

    remove)
      if [ -z "$file" ]; then echo "Usage: dotfile remove <file>"; return 1; fi
      git --git-dir="$repo_dir" --work-tree="$HOME" rm --cached "$file" 2>/dev/null &&
        echo "Untracked $file" || echo "File not tracked or error occurred"
      sed -i "\|!$file|d" "$HOME/.gitignore" && echo "Removed '!$file' from .gitignore"
      ;;

    commit)
      msg="${2:-Update dotfiles}"
      git --git-dir="$repo_dir" --work-tree="$HOME" commit -m "$msg"
      ;;

    push)
      git --git-dir="$repo_dir" --work-tree="$HOME" push
      ;;

    list)
      git --git-dir="$repo_dir" --work-tree="$HOME" ls-files
      ;;

    *)
      echo "Usage: dotfile [add|remove|commit|push|list] [file/message]"
      ;;
  esac
}
