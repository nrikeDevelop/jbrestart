#!/bin/bash

die() {
    echo ""
    echo "[?] bye"
    echo ""
    exit 0
}

banner() {

    echo ""
    echo " _______ ______  "
    echo "(_______|____  \                    _                 _   "
    echo "     _   ____)  ) ____ _____  ___ _| |_ _____  ____ _| |_ "
    echo " _  | | |  __  ( / ___) ___ |/___|_   _|____ |/ ___|_   _)"
    echo "| |_| | | |__)  ) |   | ____|___ | | |_/ ___ | |     | |_ "
    echo " \___/  |______/|_|   |_____|___/   \__)_____|_|      \__)"
    echo ""
    echo "[?] Restart trial version"
    echo ""
    echo ""
}

removeCacheAndFiles() {
    rm -rf .local/share/JetBrains/
    rm -rf ./.config/JetBrains
    rm -rf ./.cache/JetBrains

    echo ""
    echo "[+] Cache files removed"

    die

}

install() {

    if [ "$EUID" -ne 0 ]; then
        echo ""
        echo "You must be root to copy JBrestart"
        die
    fi

    cp ./jbrestart.sh /usr/local/bin/jbrestart
    echo ""
    echo "Next time execute jbrestart"
    die
}

menu() {

    banner

    echo "1. Install"
    echo "2. Execute"
    echo "3. Exit"

    read -p "Option: " option

    case "$option" in
    "1")
        install
        ;;
    "2")
        removeCacheAndFiles
        ;;

    *)
        die
        ;;
    esac

}

#MAIN

if [[ -e /usr/local/bin/jbrestart ]]; then
    removeCacheAndFiles
else
    RUNNING=true
    while [ $RUNNING ]; do
        menu
    done

fi
