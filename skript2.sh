#!/bin/bash

if [ $# -ne 2 ]; then
    echo "PouĹľitĂ­: $0 text_adresar hledany_text"
    exit 1
fi

adresar=$1
hledany_text=$2

if [ ! -d "$adresar" ]; then
    echo "AdresĂˇĹ™ '$adresar' neexistuje."
    exit 1
fi

grep -r "$hledany_text" "$adresar" --include \* | cut -d: -f1 | sort | uniq
