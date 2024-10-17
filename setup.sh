#!/bin/bash

apt update && apt install -y curl nginx git

ip=$(hostname -I | awk '{print $1}')

repo_url="https://github.com/Agung-67/shell_scripting.git"
repo_dir="/var/www/html/porto"

git clone "$repo_url" "$repo_dir"
index_file="$repo_dir/index.html"

if [[ -f "$index_file" ]]; then
    sed -i "s|<title>Tugas Portofolio |.*|<title>Tugas Portofolio | $ip|g" "$index_file"
else
    echo "<html><head><title>Tugas Portofolio | $ip</title></head><body></body></html>" >"$index_file"
fi

chmod +x "$repo_dir/setup_user.sh" "$repo_dir/repair_keys.sh"
"$repo_dir/setup_user.sh"

mv "$repo_dir/"* /var/www/html/
mkdir -p /var/www/html/pages/{shafa,agung,dahlan}

git clone https://github.com/juniyasyos/portofolio.git /var/www/html/pages/dahlan/porto
git clone https://github.com/Agung-67/cv2.git /var/www/html/pages/agung/porto
git clone https://github.com/shafaybkr23/Website-Portofolio.git /var/www/html/pages/shafa/porto
git clone https://github.com/maniknur/myCV.git /var/www/html/pages/manik/porto
git clone https://github.com/bangjur/web-portofolio /var/www/html/pages/azzuri/porto
git clone https://github.com/zaidatulnaima/my-portofolio /var/www/html/pages/ima/porto

systemctl restart nginx
