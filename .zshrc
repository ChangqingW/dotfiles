if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -d $HOME/.local/bin ]] && [[ ! $PATH =~ $HOME/.local/bin ]] && PATH=$HOME/.local/bin/:$PATH
[[ -d $HOME/bin ]] && [[ ! $PATH =~ $HOME/bin ]] && PATH=$HOME/bin/:$PATH

# VSCode falsely adding conda to end of PATH
# https://github.com/microsoft/vscode/issues/129979

# Add homebrew binaries
if  [ -f $HOME/homebrew/bin/brew ]; then
  PATH_VARS_HOMEBREW=$HOME/homebrew
  [[ ! $PATH =~ $HOME/homebrew/bin ]] && PATH=$HOME/homebrew/bin:$PATH
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
elif [ -f /usr/local/Homebrew/bin/brew ]; then
  #PATH_VARS_HOMEBREW=/usr/local/Homebrew
  PATH_VARS_HOMEBREW=/usr/local
  [[ ! $PATH =~ /usr/local/Homebrew/bin ]] && PATH=/usr/local/Homebrew/bin:$PATH
fi

if [[ -d $PATH_VARS_HOMEBREW/opt/grep/libexec/gnubin ]]; then
  PATH=$PATH_VARS_HOMEBREW/opt/grep/libexec/gnubin:$PATH
fi

# VSCode
if [[ ! $PATH =~ 'Visual Studio Code.app' ]]; then
  if [ -f $HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
    PATH=$PATH:$HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  elif [ -f /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
    PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  fi
fi

# Colorls
if type "ruby" > /dev/null && [[ ! $PATH =~ $(ruby -e 'puts File.join(Gem.user_dir, "bin")') ]]; then
  PATH=$(ruby -e 'puts File.join(Gem.user_dir, "bin")'):$PATH
fi

# history
SAVEHIST=10000
HISTSIZE=2000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Alias
if [[ -f /Library/Frameworks/R.framework/Resources/R ]]; then
  alias R="/Library/Frameworks/R.framework/Resources/R"
fi
if type "gsed" > /dev/null; then
  alias sed="gsed"  
fi
if type "colorls" > /dev/null; then
  alias ls="colorls"
  alias la="colorls -A"
fi
alias r="radian"
alias vim="nvim"
alias msg="python3 ~/Documents/wx_bot/msg.py"
alias syncbib="rclone sync ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/references.bib dropbox: -P; sed 's/date/year/g; s/journaltitle/journal/g;' ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/references.bib > ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/document.bib; rclone sync ~/OneDrive\ -\ The\ University\ of\ Melbourne/Zotero/document.bib dropbox: -P --no-update-modtime"
if [ -n "$TMUX" ]; then
  alias copy="head -c -1 | tmux loadb -w -"
else
  alias copy="head -c -1 | xclip -sel clip"
fi

function preexec {
  if [ -n "$TMUX" ] && [ -n "$(tmux show-environment | grep '^DISPLAY')" ]; then
    #export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux show-environment | grep "^DISPLAY")
  fi
}

export EDITOR="nvim"

setopt AUTO_PUSHD
setopt extendedglob # use ^ to exlucde

# Auto-suggestions
if [[ -f $PATH_VARS_HOMEBREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $PATH_VARS_HOMEBREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
fi
#/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Autojump
if [[ -s $PATH_VARS_HOMEBREW/etc/profile.d/autojump.sh ]]; then
  source $PATH_VARS_HOMEBREW/etc/profile.d/autojump.sh
elif [[ -s ~/.zsh/.autojump/etc/profile.d/autojump.sh ]]; then
  source ~/.zsh/.autojump/etc/profile.d/autojump.sh
elif [[ -s /usr/share/autojump/autojump.sh ]]; then
  source /usr/share/autojump/autojump.sh
fi

# zsh-vi-mode
if [ -f ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]; then
  source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# Syntax highlighting
if [[ -f ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
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
elif [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
  module load git
  module load R/4.2.3
  module load stornext
  module load ImageMagick/7.0.9-5
  module load gcc/12.2.0
  PATH_VARS_CONDA='/home/users/allstaff/wang.ch/miniconda3'
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
          [[ ! $PATH =~ $PATH_VARS_CONDA ]] && export PATH=$PATH_VARS_CONDA/bin:$PATH
      fi
  fi
  unset __conda_setup
# <<< conda initialize <<<
else
  echo "$PATH_VARS_CONDA not found!"
fi

[ -f $HOME/paths.sh ] && source "${HOME}/paths.sh"

# compinstall: tab selection
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# End of compinstall
