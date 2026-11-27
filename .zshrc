# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ESLINT_USE_FLAT_CONFIG=false

export SWAY_SCREENSHOT_DIR=$HOME/Pictures/screenshots

ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

alias cls=clear
# alias vim=nvim
alias hx=helix
alias vim=nvim

source $ZSH/oh-my-zsh.sh

# git-account: pick which GitHub account git uses in this shell
source ~/.config/zsh/git-account.zsh
source ~/.config/zsh/git-extras.zsh

PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)$(git_account_prompt_info)
%(?:%{$fg_bold[green]%}  :%{$fg_bold[red]%}  )%{$reset_color%}'

# fnm
FNM_PATH="/home/verissimus/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
fi

eval "$(fnm env --use-on-cd --log-level quiet)"

source ~/.config/fzf/theme.sh


export PATH=$PATH:/home/verissimus/.spicetify

export NVM_DIR="$HOME/.nvm"
# Put default node on PATH instantly (no nvm.sh load)
_nvm_default=$(ls -d "$NVM_DIR"/versions/node/v$(cat "$NVM_DIR/alias/default" 2>/dev/null)* 2>/dev/null | tail -1)
[ -n "$_nvm_default" ] && export PATH="$_nvm_default/bin:$PATH"
unset _nvm_default
# Load the real nvm only when you first run it
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

# man pages: open in neovim for syntax highlighting
export MANPAGER="nvim +Man!"
