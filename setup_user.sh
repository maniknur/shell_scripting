#!/bin/bash
declare -A USERS_KEYS
USERS_KEYS["dahlan"]="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlGVNX8dRuNZcZYof1PHLZi7bUL0Z69DyESaBxXgowiwh3OwJUIg+l4LAqu/6LVcyFVsRWGlABGoDt4vCs4dS4BYvZ7F1FkZvyd6+AmW5VJqZNpHaaRZlzRhqW612U4j5c2sGgmdWB2CkqBxvmxOQhC/3dx7SuQqCngZtwPxe+CAnW9ys3JWpEEwIit5Hfr5pUzHe9ME/9/UvSViOmt5U3PZSybw0QMpRqE6ZpDRkqV/c4GeBw0rXCIngQPO1NcE2KyK5/62Df8VAPrxGGP2ypqcNGusRgyWp+f2j5d8jdOrsxDzTNtSb2Ov+Dh+skOiXQlSrRetSCbHnJoFob9tEHtpnB4GvB/2J/XCMSA31C+rkCQUKEyWytnWh8ZOimaX0qTNINwzBQOZLC9nvcgEbpxI51eDYfo6QLMlYj/Krrjvz0gES/56girjf1f9AYVIITVJerLmnqCo0D6RqKjm5BV/tSOwfSIrs+9Bk4PjSDblSBd7nbePNQElUpKe6Hm+gKfTdbbI9N95zc40/JEdFUh2Gay/goet/zihQ6hAYEO2CX7YLmzcDJlhJ7znInLfKh0p1+UIp4x3vVItSEKbAQ7bKOMTdhmCLY33wSRVv7cuG86qCDvnczqHEJgIlAvNRAAZDQyFEgkgtJWAgkP0/5FJA4K5ADDOVj0Zj/2Z8C4w== juniyasyos@gmail.com"
USERS_KEYS["shafa"]="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDE0/slqSrnoy70EdxvzokY77vVgZzh9GQCOLU5E0cqgndc9qP+1jdBPkzmzdxIkwDrZWYOYeMQZrkZn4q510jb2QcOiH/Z93VS/xCSTS/prlC/8hX7ypg8UCX1bQUvdVEdNHr828V5urmbvyAzEr3h9jHn7KfvheGlkFa0PWWOqFIr7L2iJlz/+frgAiZLZXf0jM1mniZf/hk022ld8NlEQoYyzfB2iTe39kdgxCZ7sbGpn/Elq2FjobSHZID+Pmp+pbRnFImn638Plsmi111bUuQ2U39kUICMU1VNtjbB3pXT9+Bk+XIIcR5ZXckyrIIsCskHgE79uJ5eD/SyWlDjcPhyy06IG1dCd8LN8wg/SljXhthCY2JOru+WBxLMNBFduN0fKOdkhcPSzZZ524FLtvJYnX2df0rvDPsa519Bt4umG63j8OglMhCZUDyTwGLSo90xncxyklGWXJSfyaUPbjiLnjEm3R8dOtjVfuatmfbQ2hWD0F3jll8vwhlQcUwoRWyYBJxRolvEtQuaBxjf6iTAnw7a83CJNYgtSl/ftvFlww09SweXqjsieNhQInaETmRnJGKFEG/iV+4S4Vd/GTq8inoYtPjFsF8sUKo9MKzYFKTlgyMcmGsBESeib8TIgp/tBGYmtUdQ76GTIoEkLkoRx36wArw2d8MPnaE7jw== shafa.ayuning.2205356@students.um.ac.id"
USERS_KEYS["agung"]="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDC0ynpfv82McP3X8RgJdHaQPgASuprg8S7ZCwZXQ3g37tn70vmmq0JbcRooWPdEFkYT5M/+C1P6Hxi2uUDfuwYcSVwPwf4G+GbeynZg6MCB8vCu9dMgph0cW4DGzUjTZdUx1j2dzfHeyUQCAGZ4NJdMdKYu68Co7mWByXxe8Odlui7covym2zDbI9zl9hwYsJZfmG4F5+1OzejXYbTZR2G4wpzP0Lib2olFhmca5H8GrIiHCFIw35gjAwCWqZ8hSZTCXr/onQKuFiUQlNZlkYY8uHuyKgwByPymaHtCsbZ0u+YIr2LOlcbH1LAg+tir9+MSJqTERxjgYVhKAb8yZHFwQvqgHOJBxIIQlKmK8c1pznTaG0EMLE95sUmEBjkiFMM7Ts9LSVzODPoF52MPPP3tM/5WRHKwFbtizwxii+4J4SRRpiZYfsgN1zD5/1L5SlkxKK8E6ggWJvxHNkI1UhhS5n/wZj5ucJhuWAf5VD8zuH+nzq2002XlxUFQU98CiC3sxuRNdpg342UtKuFH8LjPNxms4posty90pFYmy4VPlVKHZv8l3BIa++BTZqWmUmnDoOyRc+6R4jUvQ0EymYlKrw7WLZ7PRUC9EdeATHEQ4g76XhQoj9BGqkVtlSzlEfgYeNU/kcPrY4du+CPJuF9kXRmabkDh2m9QgbKxql5w=="
GROUP_NAME="server_bersama"
if ! getent group $GROUP_NAME > /dev/null; then
    sudo groupadd $GROUP_NAME
fi
for USER in "${!USERS_KEYS[@]}"; do
    PUBLIC_KEY=${USERS_KEYS[$USER]}
    if ! id "$USER" &>/dev/null; then
        sudo adduser --disabled-password --gecos "" $USER
        if [ "$USER" == "dahlan" ]; then
            echo "dahlan:JikaMaka123!@#" | sudo chpasswd
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
if id "dahlan" &>/dev/null && ! sudo grep -q "^dahlan" /etc/sudoers; then
    sudo usermod -aG sudo dahlan
fi
sudo chgrp -R $GROUP_NAME /var/www/html
sudo chmod -R 775 /var/www/html
sudo passwd -l root