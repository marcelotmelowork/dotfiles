# The fuck
eval $(thefuck --alias)

# pyenv init
eval "$(pyenv init -)"

# nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# kubectl autocompletion
source <(kubectl completion zsh)
