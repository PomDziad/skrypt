#!/bin/bash
#Czcionka
setfont Lat2-Terminus16.psfu.gz -m 8859-2 &&
echo -n "Ten skrypt ma za zadanie uruchomienie 
środowiska graficznego LXDE na Arch Linuxie 
bez jego instalacji. Aby kontynuować, wpisz 'tak'.
"
read zgoda
case $zgoda in
[tak]* )
#Rozszerzanie dostępnego miejsca na USB
mount -o remount,size=2G /run/archiso/cowspace &&
#Wgrywanie niezbędnych pakietów i późniejsze usunięcie pozostałości
pacman -Sy xorg xf86-video-vesa lxde lightdm lightdm-gtk-greeter ttf-dejavu &&
pacman -Scc --noconfirm &&
#Ustawianie greetera
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf.d &&
#Dorabianie pliku na pulpit
echo "Jeżeli chcesz dodać użytkownika osobnego, to masz instrukcję:
1. Dodaj usera: useradd --create-home <nazwa usera>
2. Dograj sudo: pacman -S sudo
3. Otwórz plik: visudo /etc/sudoers
4. Pod root ALL=(ALL) ALL dodaj takie samo, tylko z nazwą użytkownika" >> ./Desktop/README.txt &&
esac
echo -n "Za chwilę powinien uruchomić sie ekran logowania. 
Użytkownik to root, a hasła nie ma. 
Możesz dodać hasło dla konta root 
za pomocą komendy passwd.
W pliku README jest info o dodawaniu
zwykłego użytkownika. 
Wpisz 'tak', aby kontynuować.
"
read zgoda1
[tak]* )
#Wystartowanie menadżera logowania
systemctl start lightdm;
esac

