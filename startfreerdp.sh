# Dieses Script startet den RDP-Client freerdp3.
#!/bin/bash -e

# Name des Windows-Terminalservers
SERVER="tsr128"
# Name der Windows-Domäne
DOMAIN="AGRICOLA"

# Mit Hilfe von Zenity wird der Nutzername und das Passwort abgefragt und in LOGIN gespeichert
LOGIN=$(zenity --forms --title="Login" --text="Geben Sie Nutzername und Passwort ein!" --add-entry="Nutzername:" --add-password="Passwort:")

# In Abhängigkeit von der Rückmeldung des Befehls
case $? in
        # im Formular wurde OK gedrückt
         0)
	 	# Nutzername und Passwort werden ausgelesen und in die Variablen USERNAME und PASSWORD gespeichert
                USERNAME="`echo $LOGIN | cut -d'|' -f1`"
	 	PASSWORD="`echo $LOGIN | cut -d'|' -f2`"
		;;
         1)
                # Es wurde Abbrechen gedrückt
                echo "Stop login.";;
        -1)
                # Es ist ein Fehler aufgetreten
                echo "An unexpected error has occurred.";;
esac


# Bemerkung: Eigentlich spielt die CASE-Anweisung keine Rolle, da das Script nicht im Terminal ausgeführt wird. Unabhängig von der Case-Anweisung wird der nächste Befehl trotzdem ausgeführt.


# Der Befehl xfreerdp3 startet den RDP-Client
xfreerdp3 /v:$SERVER /d:$DOMAIN /u:$USERNAME /p:$PASSWORD /sound:sys:alsa /drive:usb,/media/user /f

# Dabei bedeutet:
# /v: Servername
# /d: Domäne
# /u: Nutzername
# /p: Passwort
# /sound: Soundverbindung
# /drive: USB-Verbindung
# /f: Fullscreen        


