#!/bin/bash

set -x
#echo 'cachedir=/yum-cache/$basearch/$releasever' >> /etc/yum.conf
#echo keepcache=1 >> /etc/yum.conf

cp vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim
mkdir -p ~/.nvim/repos/github.com/Shougo
pushd ~/.nvim/repos/github.com/Shougo
git clone https://github.com/Shougo/dein.vim.git
popd
cp init.vim $HOME/.config/nvim/init.vim
#cp tmux.conf $HOME/.tmux.conf
cp zshrc $HOME/.zshrc

mkdir $HOME/.vim
pushd $HOME/.vim
git clone https://github.com/Shougo/neobundle.vim.git
popd

