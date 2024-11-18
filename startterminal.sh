#!/bin/bash -e

DEFAULT="18!1ceX7"

PASSWORD=$(zenity --forms --title="Passwort" --text="Bitte Passwort eingeben!" --add-password="Passwort:")


if [ "$DEFAULT" = "$PASSWORD" ]; then
	/usr/bin/qterminal
fi
