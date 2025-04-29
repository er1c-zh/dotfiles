# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/opt/homebrew/bin
export PATH=$PATH:$HOME/opt/homebrew/sbin
export PATH=$PATH:$HOME/opt/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.tools/bin
export PATH="$HOME/.local/bin:$PATH"

source $HOME/custom/path.rc
source $HOME/.secret/openai_api_key.zshrc
source $HOME/.secret/rapid_api_key.zshrc

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="candy"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"
# how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

####################################
####################################
# plugins prepare
####################################
source ~/.zplug/init.zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "junegunn/fzf"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
bindkey '^n' autosuggest-accept
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", as: plugin
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
####################################
####################################


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z sudo kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# add antlr4 to java CLASSPATH
export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"

# Set personal aliases

alias jqx="jq . "
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

export PATH="/usr/local/opt/bison/bin:$PATH"
if which rbenv > /dev/null; then 
        eval "$(rbenv init -)"; 
fi

# brew bottle source
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias video_to_gif='function video_to_gif(){ ffmpeg -i $1 -r 5 -s 1024x576 -pix_fmt rgb8 output.gif && gifsicle -O3 output.gif -o output.gif && say "Video is ready!"};video_to_gif'


. "$HOME/.local/bin/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
alias kc='sudo -E kubectl'
alias kctp='sudo -E kubectl run debug --image=busybox:1.28 -it --rm --restart=Never -- sh'
