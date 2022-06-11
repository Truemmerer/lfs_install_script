#!/bin/bash

## Partitioning
# Choose the tool


PART_OPTION=$(whiptail --backtitle "$BACKTITLE" --menu "Choose an option" 18 100 10 \
  "1" "gdisk" \
  "2" "parted" \
  "3" "fdisk" \
  "4" "other" 3>&1 1>&2 2>&3)

echo "$PART_OPTION"

# own tool
if [ $PART_OPTION == "4" ]; then

    if whiptail --backtitle "$BACKTITLE" --title "Partitioning | Now partition with a tool of your choice" --yesno "Are you done? \n Please only click Yes when you are done." 10 100; then
        echo "Yes"
    else
        echo "Abort"
        exit 0;
    fi
    
    return 1;
    
# gdisk
elif [ $PART_OPTION == "1" ]; then
    PART_DEVICE=$(whiptail --backtitle "$BACKTITLE" --title "Partitioning" --inputbox "Enter the device path with /dev/" 10 100 3>&1 1>&2 2>&3)
    echo "$PART_DEVICE"
    echo "Your chosen option:" "$PART_OPTION - gdisk $PART_DEVICE"
    $PASS | sudo -S gdisk $PART_DEVICE

    return 1;

# parted
elif [ $PART_OPTION == "2" ]; then
    PART_DEVICE=$(whiptail --backtitle "$BACKTITLE" --title "Partitioning" --inputbox "Enter the device path with /dev/" 10 100 3>&1 1>&2 2>&3)
    echo "$PART_DEVICE"
    echo "Your chosen option:" "$PART_OPTION - parted $PART_DEVICE"
    $PASS | sudo -S parted $PART_DEVICE

    return 1;

# fdisk
elif [ $PART_OPTION == "3" ]; then
    PART_DEVICE=$(whiptail --inputbox "Enter the device path with /dev/" 10 100 3>&1 1>&2 2>&3)
    echo "$PART_DEVICE"
    echo "Your chosen option:" "$PART_OPTION - fdisk $PART_DEVICE"
    $PASS | sudo -S fdisk $PART_DEVICE

    return 1;

# Not selected a tool
else
    echo "You chose Cancel."
    return 0;
fi

