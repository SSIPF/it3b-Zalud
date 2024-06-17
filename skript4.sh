#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Použití: $0 uzivatelske_jmeno 'Full Name'"
    exit 1
fi

uzivatel=$1
full_name=$2

home_dir="/home/$uzivatel"
web_dir="$home_dir/web"

if [ ! -d "$home_dir" ]; then
    echo "Uživatel '$uzivatel' neexistuje."
    exit 1
fi

sudo mkdir -p "$web_dir"
sudo ln -s "$web_dir" "/var/www/html/$uzivatel"

index_file="$web_dir/index.html"
sudo bash -c "cat > $index_file" << EOL
<!doctype html>
<html>
<head>
    <title>$full_name</title>
</head>
<body>
    <h1>User's website $full_name</h1>
    <p>This is an example web. User can now create custom web pages in ~/web/ directory.</p>
</body>
</html>
EOL

sudo chown -R "$uzivatel:$uzivatel" "$web_dir"
sudo chown "$uzivatel:$uzivatel" "$index_file"
