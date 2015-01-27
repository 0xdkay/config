#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

sudo apt-get install -y exuberant-ctags zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
cp bashrc ~/.bashrc
chsh -s `which zsh`
exec $SHELL

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +PluginInstall +qall
mv $DIR/screenrc ~/.screenrc
mv $DIR/vimfiles ~/.vim
mv $DIR/vimrc ~/.vimrc
mv $DIR/tmux.conf ~/.tmux.conf
mv $DIR/oh-my-zsh ~/.oh-my-zsh
mv $DIR/zshrc ~/.zshrc
mv $DIR/gitignore_global ~/.gitignore_global
mv $DIR/gitconfig ~/.gitconfig


# install ruby dependencies
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties


# install rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
exec $SHELL

rbenv install 2.1.5
rbenv global 2.1.5
ruby -v

echo "gem: --no-ri --no-rdoc" > ~/.gemrc


