#!bin/bash

# This is a automatic installation Script to build Linux from Scratch

## Requires 
# whiptail

if [ $(whoami) == 'root' ]; then
    echo "Please run as regular user!"
    exit 1
fi
ORIGIN_USER=$(whoami)

# Welcome Screen
BACKTITLE="LFS - Install Script | Version 11.1-systemd"
whiptail --backtitle "$BACKTITLE" --title "Welcome to Linux from Scratch" --msgbox "With this installation script you can easily build your own Linux distribution.\n However, please note that all packages must be compiled. You should therefore expect a long runtime for your computer. The duration depends on the available hardware." 10 70

## Password Dialog
correct_passwort=0

while [ $correct_passwort -lt 1 ];
do

    # Ask for Password
    PASS=$(whiptail --backtitle "$BACKTITLE" --title "Password" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)    

    # Checking if provided password is correct
    echo "$PASS" | sudo -S -k -v
    case $? in 
    0) 
        echo "Verified sudo privileges."
        correct_passwort=$((correct_passwort + 1))
        ;;
    1)
        echo "The passwort is wrong."
        ;;
    -1)
        echo "Error"
        ;;
    esac
     
done

# Detect OS
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi


## Install Dependencies
# Fedora Linux 
if [ "$OS" == "Fedora Linux" ]; then
    if (whiptail --backtitle "$BACKTITLE" --title "Requirements" --yes-button "Yes" --no-button "Wrong"  --yesno "Fedora detectet. Is this correct?" 10 60) then
        source ./Sub-Scripts/OS-Requires/fedora_requires.sh
        ret_code=$?
        echo $ret_code        
    fi
fi

# Add here more Distributions
# ret_code need 1 for true installing Dependencies

# Check if Dependencies are installed or exit
if [ $ret_code == 1 ]; then
    whiptail --backtitle "$BACKTITLE" --title "Requirements" --msgbox "Dependencies are installed."
else
    whiptail --backtitle "$BACKTITLE" --title "Requirements" --msgbox "Error by installing Dependencies."
    exit 0;
fi

## Partitioning
# Choose the tool
PART_LIST="./part_list.txt"
source ./Sub-Scripts/partition.sh
part_ret_code=$?
echo $part_ret_code

if [ $ret_code == 1 ]; then
    echo "Partitioning passed"
else
    echo "Partitioning failed"
    whiptail --backtitle "$BACKTITLE" --title "Partitioning" --msgbox "Error during partitioning."
fi

## Format partitions
source ./Sub-Scripts/format_partitions.sh
form_part_red_code=$?
echo $form_part_red_code

if [ $ret_code == 1 ]; then
    echo "Formatting of partitions successful"
else
    echo "Formatting of partitions failed"
    whiptail --backtitle "$BACKTITLE" --title "Partitioning" --msgbox "Error during formatting partitions."
fi
