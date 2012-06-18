#!/bin/sh

basedir=`readlink -f $0 | xargs dirname`

ln -Ts "$basedir/aptitude" ~/.aptitude
ln -Ts "$basedir/bash/bashrc" ~/.bashrc
ln -Ts "$basedir/fonts/fonts.conf" ~/.fonts.conf
ln -Ts "$basedir/git/gitconfig" ~/.gitconfig
ln -Ts "$basedir/gtk/themes" ~/.themes
ln -Ts "$basedir/gtk/gtkrc-2.0" ~/.gtkrc-2.0
mkdir -p ~/.config/gtk-3.0 && ln -Ts "$basedir/gtk/gtkrc-3.0" ~/.config/gtk-3.0/settings.ini
ln -Ts "$basedir/misc/bcrc" ~/.bcrc
ln -Ts "$basedir/misc/filmtagrc" ~/.filmtagrc
ln -Ts "$basedir/misc/inputrc" ~/.inputrc
ln -Ts "$basedir/misc/signature" ~/.signature
ln -Ts "$basedir/misc/urlview" ~/.urlview
ln -Ts "$basedir/mutt" ~/.mutt
ln -Ts "$basedir/ncmpcpp" ~/.ncmpcpp
ln -Ts "$basedir/vim" ~/.vim
ln -Ts "$basedir/vim/vimrc" ~/.vimrc
ln -Ts "$basedir/vim/gvimrc" ~/.gvimrc
ln -Ts "$basedir/xmonad" ~/.xmonad
ln -Ts "$basedir/xorg/wallpaper" ~/.wallpaper
ln -Ts "$basedir/xorg/xinitrc" ~/.xinitrc
ln -Ts "$basedir/xorg/Xresources" ~/.Xresources
