#!/bin/bash -e

SERVER="tsr128"
DOMAIN="AGRICOLA"
LOGIN=$(zenity --forms --title="Login" --text="Geben Sie Nutzername und Passwort ein!" --add-entry="Nutzername:" --add-password="Passwort:")


case $? in
         0)
	 	USERNAME="`echo $LOGIN | cut -d'|' -f1`"
	 	PASSWORD="`echo $LOGIN | cut -d'|' -f2`"
		;;
         1)
                echo "Stop login.";;
        -1)
                echo "An unexpected error has occurred.";;
esac


xfreerdp3 /v:$SERVER /d:$DOMAIN /u:$USERNAME /p:$PASSWORD /sound:sys:alsa /drive:usb,/media/user /f

