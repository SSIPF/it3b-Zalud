#!/bin/bash

# Definování­ cílů a zdrojů
SRC_DIR="/var/www/html"
BACKUP_DIR="/var/www/backupwww"

# Vytvoření zálohovací­ho adresáře, pokud neexistuje
if [ ! -d "$BACKUP_DIR" ]; then
    sudo mkdir -p "$BACKUP_DIR"
    sudo chown $USER:$USER "$BACKUP_DIR"
fi

# Prochází­ každý adresář v zdrojovém adresáři
for dir in "$SRC_DIR"/*; do
    if [ -d "$dir" ]; then
        base_dir=$(basename "$dir")
        tar_file="$BACKUP_DIR/$base_dir.tar.gz"

        # Zálohuje pouze pokud adresář není prázdný
        if [ "$(ls -A "$dir")" ]; then
            # Vytvoří komprimovaný archiv
            tar -czf "$tar_file" -C "$SRC_DIR" "$base_dir"
            echo "Zálohován adresář $dir do $tar_file"

            # Zkontroluje, zda je záloha novější­ než originál
            if [ -f "$tar_file" ] && [ "$tar_file" -nt "$dir" ]; then
                echo "Záloha $tar_file je novější než původní­ adresář $dir."
            else
                echo "Záloha $tar_file není­ novější­ než původní­ adresář $dir."
            fi
        else
            echo "Adresář $dir je prázdný a nebude zálohován."
        fi
    fi
done
