#!/bin/bash

## Format partitions

whiptail --backtitle "$BACKTITLE" --title "Formating Patitions" --msgbox "The next step is to format the partitions you created." 10 100

# Ask the path to the partitions

rootfs=$(whiptail --backtitle "$BACKTITLE" --title "Formating Patitions" --inputbox "Please enter the path to the root partition." 10 100 3>&1 1>&2 2>&3)
echo "rootfs: $rootfs"

bootfs=$(whiptail --backtitle "$BACKTITLE" --title "Formating Patitions" --inputbox "Please enter the path to the boot partition. /n If you want to use efi, it will ask for the efi partition which will be found under /boot/efi." 10 100 3>&1 1>&2 2>&3)
echo "bootfs: $bootfs"

efifs=$(whiptail --backtitle "$BACKTITLE" --title "Formating Patitions" --inputbox "Please enter the path to the efi partition. If you don't want to use efi, then leave the field blank." 10 100 3>&1 1>&2 2>&3)
echo "bootfs: $efifs"

# Asks which formatting should be used

FORM_OPTION=$(whiptail --backtitle "$BACKTITLE" --menu "Please choose an option how you want your partition to be formatted." 18 100 10 \
  "1" "ext4" \
  "2" "btrfs" \
  "4" "other" 3>&1 1>&2 2>&3)
echo "$FORM_OPTION"

# Make File System

if [ $FORM_OPTION == "1" ]; then
    echo "mkfs.ext4 $rootfs"
    #mkfs.ext4 $rootfs
    echo "mkfs.ext4 $bootfs"
    #mkfs.ext4 $bootfs

elif [ $FORM_OPTION == "2" ]; then
    echo "mkfs.btrfs $rootfs"
    #mkfs.btrfs $rootfs
    echo "mkfs.btrfs $bootfs"
    #mkfs.btrfs $bootfs

elif [ $FORM_OPTION == "3" ]; then
    
    if whiptail --backtitle "$BACKTITLE" --title "Formating Patitions | Now format according to your choice" --yesno "Are you done? \n Please only click Yes when you are done." 10 100; then
        echo "Yes"
    else
        echo "Abort"
        exit 0;
    fi

else
    echo "Error"
    exit 0;
fi

# Make Efi File System
if [ -n $efifs ]; then
    echo "mkfs.fat -F 32 -n EF02 $efifs"
    #mkfs.fat -F 32 -n EF02

else
    echo "no efi partition selectet"
fi

return 1;

