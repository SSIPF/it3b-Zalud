#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Použití­: $0 uzivatelske_jmeno"
    exit 1
fi

uzivatel=$1

if id "$uzivatel" &>/dev/null; then
    echo "Uživatel '$uzivatel' již existuje."
else
    sudo useradd "$uzivatel"
    echo "Uživatel '$uzivatel' byl vytvořen."

    # NastavenĂ­ hesla pro uživatele a vynucené změny při prvním přihlášení
    sudo passwd -e "$uzivatel"

    # NastavenĂ­ politik pro hesla
    sudo chage -m 5 -M 180 -W 7 "$uzivatel"

    echo "Byly nastaveny následují­cĂí politiky pro hesla pro uživatele '$uzivatel':"
    echo "- Vynucená změna hesla při první­m přihlášení
    echo "- Minimální­ doba před další­ změnou hesla je 5 dnů"
    echo "- Platnost hesla je 180 dnů"
    echo "- Uživatel dostane upozornění­ o nutnosti změny 7 dnů předem"
fi
