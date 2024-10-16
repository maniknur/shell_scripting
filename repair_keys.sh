#!/bin/bash

# Warna dan efek untuk mempercantik tampilan terminal
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"
BOLD="\033[1m"

function success_message() {
    echo -e "${GREEN}${BOLD}[SUKSES]${RESET} $1"
}

function warning_message() {
    echo -e "${YELLOW}${BOLD}[PERINGATAN]${RESET} $1"
}

function error_message() {
    echo -e "${RED}${BOLD}[ERROR]${RESET} $1"
}

read -p "Masukkan username: " USER
read -p "Masukkan public key baru untuk $USER: " PUBLIC_KEY

SSH_DIR="/home/$USER/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

if id "$USER" &>/dev/null; then
    if [ -d "$SSH_DIR" ]; then
        if [ -n "$PUBLIC_KEY" ]; then
            echo "$PUBLIC_KEY" | sudo tee "$AUTH_KEYS" > /dev/null
            sudo chmod 600 "$AUTH_KEYS"
            sudo chown $USER:$USER "$AUTH_KEYS"
            success_message "Public key untuk $USER telah diganti dengan key baru."
        else
            error_message "Public key baru tidak boleh kosong."
        fi
    else
        error_message "Folder .ssh untuk user $USER tidak ditemukan."
    fi
else
    error_message "User $USER tidak ditemukan."
fi