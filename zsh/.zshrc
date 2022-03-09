# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/thaohan/.oh-my-zsh"
export ANDROID_HOME="/Users/thaohan/Library/Android/sdk"
export ANDROID_SDK_ROOT="/Users/thaohan/Library/Android/sdk"
export FLUTTER_ROOT="/Users/thaohan/dev/projects/flutter"
export FLUTTER="/Users/thaohan/dev/projects/flutter/bin"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export OPENSSL_HOME="/opt/homebrew/opt/openssl@1.1"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# export JAVA_HOME="/opt/homebrew/opt/openjdk"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
export EDITOR=nvim
export GOLANG_BIN="/Users/thaohan/go/bin"
export GOPATH="/Users/thaohan/go"
export CARGO_BIN="/Users/thaohan/.cargo/bin"
export GEM_HOME=$HOME/.gem
export RUBY_BIN="/opt/homebrew/opt/ruby/bin"
export RBENV_ROOT="/usr/local/var/rbenv"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if ! [[ $PATH == *"$FLUTTER"* ]]; then
  export PATH="$PATH:$FLUTTER"
fi
if ! [[ $PATH == *"$JAVA_BIN"* ]]; then
  export PATH="$PATH:$JAVA_BIN"
fi
if ! [[ $PATH == *"$GOLANG_BIN"* ]]; then
  export PATH="$PATH:$GOLANG_BIN"
fi
if ! [[ $PATH == *"$ANDROID_HOME"* ]]; then
  export PATH="$PATH:$ANDROID_HOME"
fi
if ! [[ $PATH == *"$CARGO_BIN"* ]]; then
  export PATH="$PATH:$CARGO_BIN"
fi
if ! [[ $PATH == *"$GEM_HOME"* ]]; then
  export PATH=$GEM_HOME/bin:$PATH
fi
if ! [[ $PATH == *"$OPENSSL_HOME/bin"* ]]; then
  export PATH=$OPENSSL_HOME/bin:$PATH
fi
# if ! [[ $PATH == *"$RUBY_BIN"* ]]; then
#   export PATH=$RUBY_BIN:$PATH
# fi
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi




# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# FZF 
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--bind ctrl-n:down,ctrl-p:up'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git flutter)


source $ZSH/oh-my-zsh.sh
source ~/.aliases




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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias lg="lazygit"
# fzf key bindings 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias luamake=/Users/thaohan/dev/gitprojects/lua-language-server/3rd/luamake/luamake
alias python="python3"
