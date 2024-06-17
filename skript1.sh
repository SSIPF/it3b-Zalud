#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Použití: $0 nazev_souboru"
    exit 1
fi

soubor=$1

if [ ! -f "$soubor" ]; then
    echo "Soubor '$soubor' neexistuje."
    exit 1
fi

pocet_slov=$(wc -w < "$soubor")
pocet_radku=$(wc -l < "$soubor")
pocet_znaku=$(wc -m < "$soubor")

echo "Počet slov: $pocet_slov"
echo "Počet řádků: $pocet_radku"
echo "Počet znaků: $pocet_znaku"
