if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
  module load git
  module load R/flexiblas/4.4.1
  module load stornext
  module load ImageMagick/7.1.1
  module load nodejs/20.16.0
fi

[[ -d $HOME/.local/bin ]] && [[ ! $PATH =~ $HOME/.local/bin ]] && PATH=$HOME/.local/bin/:$PATH
if type "npm" > /dev/null; then 
  PATH_VARS_NPM=$(npm prefix -g)/bin
  [[ ! $PATH =~ $PATH_VARS_NPM ]] && PATH=$PATH_VARS_NPM:$PATH
fi

if [[ -d $HOME/.local/lib ]]; then
  [[ ! $LD_LIBRARY_PATH =~ $HOME/.local/lib ]] && LD_LIBRARY_PATH=$HOME/.local/lib/:$LD_LIBRARY_PATH
  [[ ! $LDFLAGS =~ $HOME/.local/lib ]] && LDFLAGS="-L$HOME/.local/lib $LDFLAGS"
  [[ ! $PKG_CONFIG_PATH =~ $HOME/.local/lib/pkgconfig ]] && PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH
fi
if [[ -d $HOME/.local/lib64 ]]; then
  [[ ! $LD_LIBRARY_PATH =~ $HOME/.local/lib64 ]] && LD_LIBRARY_PATH=$HOME/.local/lib64/:$LD_LIBRARY_PATH
  [[ ! $LDFLAGS =~ $HOME/.local/lib64 ]] && LDFLAGS="-L$HOME/.local/lib64 $LDFLAGS"
  [[ ! $PKG_CONFIG_PATH =~ $HOME/.local/lib64/pkgconfig ]] && PKG_CONFIG_PATH=$HOME/.local/lib64/pkgconfig:$PKG_CONFIG_PATH
fi
if [[ -d $HOME/.local/include ]]; then
  [[ ! $CPPFLAGS =~ $HOME/.local/include ]] && CPPFLAGS="-I$HOME/.local/include $CPPFLAGS"
  [[ ! $CFLAGS =~ $HOME/.local/include ]] && CFLAGS="-I$HOME/.local/include $CFLAGS"
  [[ ! $CXXFLAGS =~ $HOME/.local/include ]] && CXXFLAGS="-I$HOME/.local/include $CXXFLAGS"
fi
[[ -d $HOME/.local/share/man ]] && [[ ! $MANPATH =~ $HOME/.local/share/man ]] && MANPATH=$HOME/.local/share/man:$MANPATH
[[ -f $HOME/.cargo/env ]] && . "$HOME/.cargo/env"
[[ -d $HOME/.zsh/eza/completions/zsh ]] && export FPATH="$HOME/.zsh/eza/completions/zsh:$FPATH"

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

PATH=$((\ls -d $PATH_VARS_HOMEBREW/opt/*/libexec/gnubin) 2>/dev/null | tr '\n' ':')$PATH

# VSCode
if [[ ! $PATH =~ 'Visual Studio Code.app' ]]; then
  if [ -f $HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
    PATH=$PATH:$HOME/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  elif [ -f /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
    PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  fi
fi

# history
SAVEHIST=10000
HISTSIZE=2000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

export EDITOR="nvim"
export PAGER="less"
export MANPAGER='nvim +Man!'
setopt AUTO_PUSHD
setopt extendedglob # use ^ to exlucde

# Alias
if [[ -f /Library/Frameworks/R.framework/Resources/R ]]; then
  alias R="/Library/Frameworks/R.framework/Resources/R"
fi
if type "eza" > /dev/null; then
  alias ls="eza --icons --color=always --git"
  alias lt="eza -T --icons -l -smodified -r --color=always --git"
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
st() {
  if [ -n "$TMUX" ]; then
    tmux disable-prefix; command ssh "$@"; tmux restore-prefix 
  else
    command ssh "$@"
  fi
}

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
if [[ -f $PATH_VARS_HOMEBREW/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source $PATH_VARS_HOMEBREW/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# broot
[[ -f $HOME/.config/broot/launcher/bash/br ]] && . "$HOME/.config/broot/launcher/bash/br"

if type "micromamba" > /dev/null; then 
  PATH_VARS_CONDA=$(which micromamba)
  export MAMBA_EXE=$PATH_VARS_CONDA
else 
  for folder (
    $HOME/mambaforge
    $HOME/miniconda3
    $PATH_VARS_HOMEBREW/opt/micromamba
    ); [ -d "$folder" ] && PATH_VARS_CONDA=$folder && break
fi

if (( ${+PATH_VARS_CONDA} )) && [ -e $PATH_VARS_CONDA ]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

  if [[ $PATH_VARS_CONDA =~ 'micromamba' ]]; then
    export MAMBA_ROOT_PREFIX=$HOME/micromamba
    [ -e "$PATH_VARS_CONDA/bin/micromamba" ] && export MAMBA_EXE=$PATH_VARS_CONDA/bin/micromamba
    __conda_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
  else
    __conda_setup="$($PATH_VARS_CONDA/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
  fi
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f $PATH_VARS_CONDA/etc/profile.d/conda.sh ]; then
          . $PATH_VARS_CONDA/etc/profile.d/conda.sh
      elif [ -f $PATH_VARS_CONDA/etc/profile.d/micromamba.sh ]; then
          . $PATH_VARS_CONDA/etc/profile.d/micromamba.sh
      else
          [[ ! $PATH =~ $PATH_VARS_CONDA ]] && export PATH=$PATH_VARS_CONDA/bin:$PATH
      fi
  fi
  unset __conda_setup

  if [ -f $PATH_VARS_CONDA/etc/profile.d/mamba.sh ]; then
    . $PATH_VARS_CONDA/etc/profile.d/mamba.sh
  fi
# <<< conda initialize <<<
else
  echo conda path $PATH_VARS_CONDA not found!
fi

[ -f $HOME/paths.sh ] && source "${HOME}/paths.sh"

alias tmux=$(which tmux) # preserve tmux across conda envs
function preexec {
  if [ -n "$TMUX" ] && [ -n "$(tmux show-environment | grep '^DISPLAY')" ]; then
    #export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux show-environment | grep "^DISPLAY")
  fi
}

# atuin
# https://github.com/atuinsh/atuin/issues/977
zvm_after_init_commands+=(eval "$(atuin init zsh --disable-up-arrow)")
bindkey '^r' atuin-search

reverse_complement() {
    Rscript -e "Biostrings::DNAString('$1') |> Biostrings::reverseComplement() |> as.character() |> paste0('\n') |> cat()"
}

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# compinstall: tab selection
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# End of compinstall

