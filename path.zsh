# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Make sure coreutils are loaded before system commands
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Use gnu-sed instead of gsed
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"

# Use gnu-find instead of gfind
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"

# use homebrew curl
export PATH="$(brew --prefix curl)/bin:$PATH"

# Visual Studio Code
export PATH="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# User binaries
export PATH="$HOME/bin:$PATH"
