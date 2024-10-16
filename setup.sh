#!/bin/bash
apt update && apt install -y curl apache2

TOKEN=$(curl -s --request PUT "http://169.254.169.254/latest/api/token" --header "X-aws-ec2-metadata-token-ttl-seconds: 3600")
ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 --header "X-aws-ec2-metadata-token: $TOKEN")

repo_url="https://github.com/juniyasyos/shell_scripting.git"
repo_dir="/var/www/html/porto"

git clone "$repo_url" "$repo_dir"
index_file="$repo_dir/index.html"

if [[ -f "$index_file" ]]; then
    sed -i "s|<title>Tugas Portofolio |.*|<title>Tugas Portofolio | $ip|g" "$index_file"
else
    echo "<html><head><title>Tugas Portofolio | $ip</title></head><body></body></html>" > "$index_file"
fi

mv "$repo_dir/"* /var/www/html/
rm -rf "$repo_dir" /var/www/html/index.html

mkdir -p /var/www/html/pages/{shafa,agung,dahlan}

git clone https://github.com/juniyasyos/portofolio.git /var/www/html/pages/dahlan/porto
git clone https://github.com/Agung-67/cv2.git /var/www/html/pages/agung/porto
