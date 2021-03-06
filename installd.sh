#pacman
pacman -Sy &&

#Czas
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && hwclock --systohc &&

#Język
echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen &&
echo "LANG=pl_PL.UTF-8" > /etc/locale.conf &&

#Nazwa kompa
echo "ArchLinux" > /etc/hostname &&

#bootloader (grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB dla EFI)
pacman -S --noconfirm grub &&
grub-install --target=i386-pc /dev/sda &&
grub-mkconfig -o /boot/grub/grub.cfg &&

#podstawy środowiska
pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter xf86-video-vesa ttf-dejavu openbox sudo dialog &&

#Hasło admina
echo "Wpisz hasło dla konta root"
passwd &&

#dodawanie użytkownika (sudo ręcznie)
echo "Wpisz nazwę użytkownika do stworzenia (małe litery): "
read user
useradd --create-home $user &&
passwd $user &&

#włączanie lightdm
echo "[Seat:*]
greeter-session=lightdm-gtk-greeter" > /etc/lightdm/lightdm.conf.d &&
systemctl enable lightdm && echo "Teraz zresetuj"

