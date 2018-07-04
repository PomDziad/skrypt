#!/bin/bash
#Czcionka
setfont Lat2-Terminus16.psfu.gz -m 8859-2 &&

#Zgoda
echo "NAJPIERW TRZEBA PRZYGOTOWAĆ I ZAMONTOWAĆ PARTYCJE! wpisz 'nie', jeżeli już są zrobione w cfdisk"
read zgoda
case $zgoda in
"nie") exit ;;
esac

#Instalacja podstawy
pacstrap /mnt base

#FSTAB
genfstab >U /mnt >> /mnt/etc/fstab

#chrootowanie
arch-chroot /mnt

#Czas
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && hwclock --systohc &&

#Język
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen &&
echo "LANG=pl_PL.UTF-8" > /etc/locale.conf &&

#Nazwa kompa
echo "ArchLinux" > /etc/hostname &&

#Hasło admina
echo "Wpisz hasło dla konta root"
passwd &&

#bootloader (grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB dla EFI)
pacman -S grub &&
grub-install --target=i386-pc /dev/sda &&
grub-mkconfig -o /boot/grub/grub.cfg &&

#dodawanie użytkownika (sudo ręcznie)
echo "Wpisz nazwę użytkownika do stworzenia (małe litery): "
read user
useradd --create-home $user &&
passwd $user &&

#podstawy środowiska
pacman -S xorg lightdm ligthdm-gtk-greeter xf86-video-vesa ttf-dejavu lxde leafpad sudo &&

#Ustawianie greetera
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf.d &&

#włączanie lightdm
systemctl enable lightdm && echo "Teraz zresetuj"




