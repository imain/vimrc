#!/bin/bash

set -x
#echo 'cachedir=/yum-cache/$basearch/$releasever' >> /etc/yum.conf
#echo keepcache=1 >> /etc/yum.conf
yum update -y
yum install -y epel-release
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
yum install -y git tig docker neovim vim-enhanced telnet epel-release ruby rubygems yum-plugins-priorities deltarpm zsh tmux gcc python34-neovim python34-typing
yum -y install https://dprince.fedorapeople.org/tmate-2.2.1-1.el7.centos.x86_64.rpm
if [ ! -d /home/imain ]; then useradd -s /bin/zsh imain; fi
echo '%imain ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/imain
     
cd /root
git clone https://github.com/imain/vimrc.git
cp vimrc/vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim
mkdir -p ~/.nvim/repos/github.com/Shougo
pushd ~/.nvim/repos/github.com/Shougo
git clone https://github.com/Shougo/dein.vim.git
popd
cp vimrc/init.vim $HOME/.config/nvim/init.vim
cp vimrc/tmux.conf $HOME/.tmux.conf
cp vimrc/zshrc $HOME/.zshrc

mkdir $HOME/.vim
pushd $HOME/.vim
git clone https://github.com/Shougo/neobundle.vim.git
popd

