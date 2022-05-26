# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -e
setopt HIST_IGNORE_ALL_DUPS
zstyle ':zim:zmodule' use 'degit'
setopt CORRECT
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
zstyle ':zim:git' aliases-prefix 'g'

export EDITOR="nvim"
export TERMINAL="alacritty"

ZIM_HOME=~/.config/zim

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://raw.githubusercontent.com/zimfw/zimfw/master/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh
source ${ZIM_HOME}/alias.zsh

path+=(~/.local/bin)
export PATH
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
