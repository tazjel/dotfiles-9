#!/bin/sh

basedir=`readlink -f $0 | xargs dirname`

mkdir -p ~/.aptitude
ln -Ts "$basedir/aptitude/config" ~/.aptitude/config
ln -Ts "$basedir/bash/bashrc" ~/.bashrc
mkdir -p ~/local/bin
ln -Ts "$basedir/bin/filmtag" ~/local/bin/filmtag
ln -Ts "$basedir/bin/imap-unseen" ~/local/bin/imap-unseen
ln -Ts "$basedir/git/gitconfig" ~/.gitconfig
ln -Ts "$basedir/gtk/themes" ~/.themes
ln -Ts "$basedir/gtk/gtkrc-2.0" ~/.gtkrc-2.0
mkdir -p ~/.config/gtk-3.0
ln -Ts "$basedir/gtk/gtkrc-3.0" ~/.config/gtk-3.0/settings.ini
ln -Ts "$basedir/misc/bcrc" ~/.bcrc
ln -Ts "$basedir/misc/filmtagrc" ~/.filmtagrc
ln -Ts "$basedir/misc/inputrc" ~/.inputrc
ln -Ts "$basedir/misc/mailcap" ~/.mailcap
ln -Ts "$basedir/misc/signature" ~/.signature
ln -Ts "$basedir/misc/urlview" ~/.urlview
ln -Ts "$basedir/mutt/muttrc" ~/.muttrc
mkdir -p ~/.ncmpcpp
ln -Ts "$basedir/ncmpcpp/config" ~/.ncmpcpp/config
ln -Ts "$basedir/vim" ~/.vim
ln -Ts "$basedir/vim/gvimrc" ~/.gvimrc
ln -Ts "$basedir/vim/vimrc" ~/.vimrc
mkdir -p ~/.xmonad
ln -Ts "$basedir/xmonad/xmonad.hs" ~/.xmonad/xmonad.hs
ln -Ts "$basedir/xmonad/xmobarrc" ~/.xmobarrc
ln -Ts "$basedir/xorg/Xresources" ~/.Xresources
ln -Ts "$basedir/xorg/fonts.conf" ~/.fonts.conf
ln -Ts "$basedir/xorg/wallpaper" ~/.wallpaper
ln -Ts "$basedir/xorg/xinitrc" ~/.xinitrc
