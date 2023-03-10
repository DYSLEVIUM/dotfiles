#! /bin/bash

# CONSTANTS
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# FUNCTIONS
print() {
    echo -e "$1$2${ENDCOLOR}"
}

newline() {
    printf "\n"
}

# Update the system clock
print $GREEN "Update the system"

timedatectl set-ntp true
timedatectl status

newline

# Synchronize the database
print $GREEN "Synchronize the database"

pacman -Syy

newline

# Get fastest mirrors
print $GREEN "Getting the fastest mirrors"

pacman -Syy pacman-contrib --noconfirm
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --verbose --threads 24 --number 50 --fastest 25 --country "India,Bangladesh,China,Singapore,Thailand,Indonesia,Hong Kong,Taiwan,Vietnam" --protocol https --completion-percent 100 --age 72 --score 10 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

newline
