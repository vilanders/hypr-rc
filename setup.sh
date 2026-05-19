#!/bin/bash

echo "This rice is designed specifically for an arch-based OS."
echo "Would you like to install hyprland with my rice?"
read -p "[y/N] " decision

if [ "$decision" = "y" ]; then

  sudo pacman -Syu --needed base-devel hyprland rofi mpv kitty breeze waybar pavucontrol-qt hyprshot dunst thunar udiskie btop fastfetch zsh ttf-jetbrains-mono libreoffice-fresh flatpak git adw-gtk-theme gtk3 gtk4 qt6ct gtklock

  git clone https://aur.archlinux.org/yay.git ~/yay

  if cd ~/yay; then
    echo "building AUR helper... "
    makepkg -si
  fi

  yay -S waypaper mpvpaper gtk2 wlogout grub-silent bauh

  cp ~/hypr-rc/.config/* ~/.config/

  cp ~/hypr-rc/wallpapers ~/

  layout=$(cat ~/.config/hypr/hyprland.conf | grep "kb_layout" | awk -F '=' '{print $2}' | xargs)

  if [ "$layout" = "us" ]; then
    echo "'us' keyboard layout has been detected on your configuration."
    echo "Would you like to change it to 'latam'?"
    read -p "[y/N]" ly

    if [ "$ly" = "y" ]; then
      sed -i 's/kb_layout = us/kb_layout = latam/g' ~/.config/hypr/hyprland.conf
    fi

  fi

  echo "Installation completed!"

fi
