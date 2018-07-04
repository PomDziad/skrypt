#!/bin/bash
#Czcionka
setfont Lat2-Terminus16.psfu.gz -m 8859-2 &&

#Zgoda
echo "NAJPIERW TRZEBA PRZYGOTOWAĆ I ZAMONTOWAĆ PARTYCJE! wpisz 'nie', jeżeli NIE są zrobione w cfdisk"
read zgoda
case $zgoda in
"nie") exit ;;
esac

#Instalacja podstawy
pacstrap /mnt base &&

#FSTAB
genfstab -U /mnt >> /mnt/etc/fstab &&

#chrootowanie
wget raw.githubusercontent.com/PomDziad/skrypt/master/installd.sh > /mnt/installd.sh && arch-chroot /mnt bash installd.sh &&
clear
rm install.sh

