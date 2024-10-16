#!/bin/bash
declare -A USERS_KEYS
USERS_KEYS["user1"]=""
USERS_KEYS["user2"]=""
USERS_KEYS["user3"]=""
GROUP_NAME="server_bersama"
if ! getent group $GROUP_NAME > /dev/null; then
    sudo groupadd $GROUP_NAME
fi
for USER in "${!USERS_KEYS[@]}"; do
    PUBLIC_KEY=${USERS_KEYS[$USER]}
    if ! id "$USER" &>/dev/null; then
        sudo adduser --disabled-password --gecos "" $USER
        if [ "$USER" == "user1" ]; then
            echo "user:password123!@#" | sudo chpasswd
        else
            echo "$USER:password" | sudo chpasswd
        fi
    fi
    SSH_DIR="/home/$USER/.ssh"
    if [ ! -d "$SSH_DIR" ]; then
        sudo mkdir "$SSH_DIR"
        sudo chmod 700 "$SSH_DIR"
        sudo chown $USER:$USER "$SSH_DIR"
    fi
    AUTH_KEYS="$SSH_DIR/authorized_keys"
    if [ ! -f "$AUTH_KEYS" ]; then
        echo "$PUBLIC_KEY" | sudo tee "$AUTH_KEYS" > /dev/null
        sudo chmod 600 "$AUTH_KEYS"
        sudo chown $USER:$USER "$AUTH_KEYS"
    elif ! grep -Fxq "$PUBLIC_KEY" "$AUTH_KEYS"; then
        echo "$PUBLIC_KEY" | sudo tee -a "$AUTH_KEYS" > /dev/null
    fi
    sudo usermod -aG $GROUP_NAME $USER
done
if id "user1" &>/dev/null && ! sudo grep -q "^user1" /etc/sudoers; then
    sudo usermod -aG sudo user1
fi
sudo chgrp -R $GROUP_NAME /var/www/html
sudo chmod -R 775 /var/www/html
sudo passwd -l root