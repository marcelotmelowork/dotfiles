#!/bin/sh

export DOTFILES="${HOME}/.dotfiles"

echo "Setting up your Mac..."

echo "Updating software..."
while true; do
    read -p "Do you wish to update the OS? " yn
    case $yn in
        [Yy]* ) sudo softwareupdate -i -a; break;;
        [Nn]* ) break;;
        * ) echo "Please answer y(yes) or n(no).";;
    esac
done

echo "Installing XCode Command Line Tools..."
xcode-select --install

# Check for Oh My Zsh and install if we don't have it
if test ! "$(which omz)"; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
  git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Check for Homebrew and install if we don't have it
if test !" $(which brew)"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Symlink custom oh-my-zsh
for custom in "$DOTFILES"/*.zsh; do
    ln -s $custom ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
done

# Set macOS preferences - we will run this last because this will reload the shell
echo "Setting MacOS preferences..."
while true; do
    read -p "Have you checked the hostname in .macos file? " yn
    case $yn in
        [Yy]* ) source $DOTFILES/.macos; break;;
        [Nn]* ) break;;
        * ) echo "Please answer y(yes) or n(no).";;
    esac
done

# adding user to sudoers
sudo tee /etc/sudoers.d/"$(whoami)" > /dev/null << EOF
$(whoami)    ALL = (ALL) NOPASSWD: ALL
EOF

# Setting zsh homebrew as system zsh
sudo dscl . -create /Users/"$(whoami)" UserShell "$(brew --prefix)"//bin/zsh
