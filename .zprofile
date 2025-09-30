
eval "$(/opt/homebrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"


# Added by Toolbox App
export PATH="$PATH:/Users/jesperherrloff/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$PATH:/opt/homebrew/Cellar/php@8.1/8.1.26/bin/"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export JAVA_HOME=/usr/libexec/java_home
export PATH="$PATH:/opt/homebrew/Cellar/john-jumbo/1.9.0_1/share/john/"

# Created by `pipx` on 2025-04-18 07:29:23
export PATH="$PATH:/Users/jesperherrloff/.local/bin"
