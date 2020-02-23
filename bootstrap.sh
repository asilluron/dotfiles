#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

#git pull origin master;

function doIt() {
	echo "DOING IT";
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
  cd ~;
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git terminal;
	source ~/.bash_profile;
}


doIt;

# If we on macOS, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew update
      brew install htop mysql node ruby wget trash
  fi

  # echo 'Tweaking macOS...'
 source '.macos'

  # https://github.com/sindresorhus/quick-look-plugins
  echo 'Installing Quick Look plugins...'
    brew cask install suspicious-package quicklook-json qlmarkdown qlstephen qlcolorcode
fi

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

