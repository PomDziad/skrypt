#!/bin/bash
#Czcionka
setfont Lat2-Terminus16.psfu.gz -m 8859-2 &&

echo "Ten skrypt ma za zadanie uruchomienie 
środowiska graficznego LXDE na Arch Linuxie 
bez jego instalacji. Aby kontynuować, wciśnij ENTER."
read zgoda &&

#Rozszerzanie dostępnego miejsca na USB
mount -o remount,size=2G /run/archiso/cowspace &&

#Wgrywanie niezbędnych pakietów i późniejsze usunięcie pozostałości
pacman -Sy --noconfirm xorg xf86-video-vesa lxde lightdm lightdm-gtk-greeter ttf-dejavu leafpad &&
pacman -Scc --noconfirm &&

#Ustawianie greetera
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf.d &&

#Czytajka
wget raw.githubusercontent.com/PomDziad/skrypt/master/Czytaj_to &&

#Wystartowanie menadżera logowania
systemctl start lightdm;
