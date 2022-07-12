#!/bin/bash

# set -x
# set -e

if [ "${MACKUP_PATH}" = "" ]; then
  echo "Please set the MACKUP_PATH environment variable."
  exit 1
fi

if [ "${DOTFILES}" = "" ]; then
  echo "Please set the DOTFILES environment variable."
  exit 1
fi

echo "Copying from mackup to dotfiles..."
cp -fv "${MACKUP_PATH}/Mackup/.mackup.cfg" "${DOTFILES}/.mackup.cfg"
cp -fv "${MACKUP_PATH}/Mackup/.zshrc" "${DOTFILES}/.zshrc"

echo "Adding the files to git to be commited..."
git add ${DOTFILES}/.mackup.cfg
git add ${DOTFILES}/.zshrc

echo "Do you want to commit and push the changes (Y/n)?"
read -n1 should_commit

if [ "$should_commit" != "n" ] && [ "$should_commit" != "N" ]; then
  echo -e "\nCommiting the changes..."
  git commit -am "Sync from Mackup"
  git push -u origin HEAD
fi
