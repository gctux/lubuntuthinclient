# Dieses Script startet den Terminal um Programme zu starten. 
# Das Script ist nicht für den User gedacht und startet mit einer Tastenkombination
# Es ist Passwortgeschützt
#!/bin/bash -e

# Ein Passwort für das Script. Achtung: Wenn der Nutzer auf irgendeine Weise das Script anzeigen lassen kann, kann er das Passwort lesen.
DEFAULT="PasswortVonAdmin"

# Eingabe des Passworts im Formular
PASSWORD=$(zenity --forms --title="Passwort" --text="Bitte Passwort eingeben!" --add-password="Passwort:")

# Wenn die Passwörter übereinstimmen wird das Terminal gestartet
if [ "$DEFAULT" = "$PASSWORD" ]; then
	/usr/bin/qterminal
fi
