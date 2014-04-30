#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

sudo apt-get install exuberant-ctags
sudo apt-get install -y zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
mv $DIR/screenrc ~/.screenrc
mv $DIR/vimfiles ~/.vim
mv $DIR/vimrc ~/.vimrc
mv $DIR/tmux.conf ~/.tmux.conf
cp bashrc ~/.bashrc
mv $DIR/oh-my-zsh ~/.oh-my-zsh
mv $DIR/zshrc ~/.zshrc
mv $DIR/gitignore_global ~/.gitignore_global
mv $DIR/gitconfig ~/.gitconfig
chsh -s `which zsh`
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +PluginInstall +qall


