autoload -U colors && colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export PROMPT_COMMAND='history -a'

autoload -U compinit && compinit -u

ZSH_THEME="powerlevel10k/powerlevel10k"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

bindkey -s '^e' 'fzf-tmux\n'
bindkey -s '^i' 'cht\n'


# aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias hyprrc="nvim ~/.config/nvim"
alias ls='ls --color=auto'
alias vim='nvim'
alias make50='make CC=clang CFLAGS="-ferror-limit=1 -gdwarf-4 -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-gnu-folding-constant -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wshadow" LDLIBS="-lcrypt -lcs50 -lm" '

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=($HOME/.zsh/plugins/zsh-completions/src $fpath)
source $HOME/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh/plugins/git/git.plugin.zsh
source $HOME/.zsh/plugins/z/z.plugin.zsh

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh