if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -d $HOME/.local/bin ]] && PATH=$HOME/.local/bin/:$PATH
[[ -d $HOME/bin ]] && PATH=$HOME/bin/:$PATH


# Add homebrew binaries
if  [ -f $HOME/homebrew/bin/brew ]; then
  PATH_VARS_HOMEBREW=$HOME/homebrew
  PATH=$HOME/homebrew/bin:$PATH
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
elif [ -f /usr/local/homebrew/bin/brew ]; then
  PATH_VARS_HOMEBREW=/usr/local/homebrew
  PATH=/usr/local/homebrew/bin:$PATH
fi

# VSCode
if [ -f $HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
  PATH=$PATH:$HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
elif [ -f /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code]; then
  PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
fi

# Colorls
if type "ruby" > /dev/null; then
  PATH=$(ruby -e 'puts File.join(Gem.user_dir, "bin")'):$PATH
fi

SAVEHIST=2000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

# Alias
if [[ -f /Library/Frameworks/R.framework/Resources/R ]]; then
  alias R="/Library/Frameworks/R.framework/Resources/R"
fi
if type "gsed" > /dev/null; then
  alias sed="gsed"  
fi
if type "gsed" > /dev/null; then
  alias ls="colorls"
  alias la="colorls -A"
fi
alias r="radian"
alias vim="nvim"
alias msg="python3 ~/Documents/wx_bot/msg.py"
alias syncbib="rclone sync ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/references.bib dropbox: -P; sed 's/date/year/g; s/journaltitle/journal/g;' ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/references.bib > ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/document.bib; rclone sync ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/document.bib dropbox: -P --no-update-modtime"
export EDITOR="nvim"

setopt AUTO_PUSHD
setopt extendedglob # use ^ to exlucde

# Syntax highlighting
if [[ -f ~/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#C678DD,bold,underline"  

# Auto-suggestions
if [[ -f ~/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
fi

# Autojump
if [[ -s $PATH_VARS_HOMEBREW/etc/profile.d/autojump.sh ]]; then
  source $PATH_VARS_HOMEBREW/etc/profile.d/autojump.sh
elif [[ -s ~/.zsh/.autojump/etc/profile.d/autojump.sh ]]; then
  source ~/.zsh/.autojump/etc/profile.d/autojump.sh
fi

# zsh-vi-mode
if [ -f ~/.zsh-vi-mode/zsh-vi-mode.plugin.zsh ]; then
  source  ~/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
elif [ -f $PATH_VARS_HOMEBREW/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]; then
  source $PATH_VARS_HOMEBREW/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# iterm2
if [[ -f ${HOME}/.iterm2_shell_integration.zsh ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Powerlevel10k
if [[ -f $PATH_VARS_HOMEBREW/opt/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source $PATH_VARS_HOMEBREW/opt/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/powerlevel10k/powerlevel10k.zsh-theme
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


if [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
  module load git
  module load R/4.1.3
  module load stornext
  module load htslib/1.9
  module load gcc/11.1.0
  PATH_VARS_CONDA='/stornext/System/data/apps/anaconda3/anaconda3-2019.03'
elif [ -d $HOME/opt/anaconda3 ]; then
  PATH_VARS_CONDA=$HOME/opt/anaconda3
elif [ -d "/opt/anaconda3" ]; then
  PATH_VARS_CONDA='/opt/anaconda3'
fi

if [ -d $PATH_VARS_CONDA ]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$($PATH_VARS_CONDA/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f $PATH_VARS_CONDA/etc/profile.d/conda.sh ]; then
          . $PATH_VARS_CONDA/etc/profile.d/conda.sh
      else
          export PATH=$PATH_VARS_CONDA/bin:$PATH
      fi
  fi
  unset __conda_setup
# <<< conda initialize <<<
else
  echo "$PATH_VARS_CONDA not found!"
fi

# compinstall: tab selection
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# End of compinstall
