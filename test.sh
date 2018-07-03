#!/bin/bash
#Rozszerzanie dostępnego miejsca na USB
mount -o remount,size=2G /run/archiso/cowspace &&
#Wgrywanie niezbędnych pakietów i późniejsze usunięcie pozostałości
pacman -Sy xorg xf86-video-vesa lxde lightdm lightdm-gtk-greeter ttf-dejavu &&
pacman -Scc --noconfirm &&
#Ustawianie greetera
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf.d &&
#Hasło admina, w razie czego
echo "teraz dodajesz haslo admina" && passwd &&
#Dorabianie pliku na pulpit
echo "Jeżeli chcesz dodać użytkownika osobnego, to masz instrukcję:
1. Dodaj usera: useradd --create-home <nazwa usera>
2. Dograj sudo: pacman -S sudo
3. Otwórz plik: visudo /etc/sudoers
4. Pod root ALL=(ALL) ALL dodaj takie samo, tylko z nazwą użytkownika" >> README!!!.txt &&
#Wystartowanie menadżera logowania
systemctl start lightdm
