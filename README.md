# Einrichten eines RDP-Thin-Clients auf der Basis von Lubuntu

In diesem Repository wird beschrieben, wie man einen RDP-Thin-Client auf der Basis von Lubuntu einrichten kann. Die notwendigen Scripte und Konfigurationsdateien werden zur Verfügung gestellt.

Der Thin Client hat einen administrativen Nutzer (admin) mit sudo-Rechten und einen Standardnutzer (user) durch den die Anmeldung am Terminalserver erfolgen. Nach Booten des Systems soll der User automatisch angemeldet werden. Dort hat er nur die folgenden Möglichkeiten:

  * Anmelden am Terminalserver
  * Herunterfahren des Systems
  * Neustart des Systems

Das Starten anderer Anwendungen bzw. das Verändern der Konfiguration des Systems soll nicht möglich oder durch Passwort geschützt sein. Nach dem Neustart sollen sich die Nutzereinstellung wieder im ursprünglichen Zustand befinden.

## Inhaltsverzeichnis


- [Installation von Lubuntu](#installation-von-lubuntu)
- [Nachinstallation von Paketen](#nachinstallation-von-paketen)
- [Einrichten des Standardnutzers](#einrichten-des-standardnutzers)
- [Anpassen der Oberfäche des Standardbenutzers](#anpassen-der-oberfäche-des-standardbenutzers)

## Installation von Lubuntu

Zur Installation wurde die aktuell stabile Version 24.04.1 (https://lubuntu.me/downloads/) von Lubuntu verwendet. Eine Installationsanleitung findet man hier:

https://manual.lubuntu.me/stable/1/Installing_lubuntu.html

Bei der Installation wurde minimale Installation gewählt und ein Nutzer mit administrativen Rechten (sudo, Nutzername: admin) eingerichtet. Man sollte bei der Installation "gesamte Festplatte löschen" auswählen.

## Nachinstallation von Paketen

Für den Thin Client wird noch weitere Software benötigt:

  * Featherpad - ein einfacher Editor zum Bearbeiten der Scripte
  * Freerdp3 - der eigentliche RDP-Client
  * Zenity - eine GUI-Bibliothek für Shellscripte
  * Falkon - ein einfacher schneller Webbrowser

```
sudo apt -y upgrade && sudo apt -y dist-upgrade
sudo apt install featherpad freerdp3-x11 freerdp3-wayland zenity falkon
```

## Einrichten des Standardnutzers 

**Möglichkeit 1: über die Shell**

Mit dem folgenden Befehl in der Shell wird ein Standardbenutzer mit dem Nutzernamen "user" angelegt

```
sudo adduser user
```

Folgende Dinge werden im Dialog abgefragt:
  * Passwort
  * Wiederholung des Passworts
  * Vollständiger Name: _User_
  * Zimmernummer: _leer lassen_
  * Telefon geschäftlich: _leer lassen_
  * Telefon privat: _leer lassen_
  * Sonstiges: _leer lassen_

Im Anschluss muss nach bestätigt werden, dass die Daten korrekt sind.

**Möglichkeit 2: über die grafische Benutzerverwaltung**

Über das Anwendungsmenü -> Einstellungen -> LXQt-Systemeinstellungen -> Benutzer und Gruppen

Über die Schaltfäche "Hinzufügen" kann man nun einen neuen Nutzer anlegen. Im Reiter Allgemein trägt man den Nutzername (user) ein. Dann kann man noch den vollständigen Namen (User) eintragen. Es ist sinnvoll als primäre Gruppe noch den Nutzernamen einzutragen, so dass eine entsprechende Gruppe angelegt wird. (Ubuntu Standard)

## Installation der Scripte für den Standardnutzer

Der Nutzer soll letztendlich nur zwei Shellscripte ausführen können. Die Scripte müssen mit Administratorrechten nach /usr/local/bin kopiert werden und ausführbar gemacht werden. Ich gehe davon aus, dass im Verzeichnist der Scripte der User Admin ein Terminal geöffnet hat.

```
sudo cp startfreerdp.sh startterminal.sh /usr/local/bin/
cd /usr/local/bin
sudo chmod +x startfreerdp.sh
sudo chmod +x startterminal.sh
```
Beide Scripte sind in diesem Git-Repository enthalten, die Funktionsweise wird im Quelltext durch Kommentare beschrieben. Nachdem die Skripte kopiert sind sollte man ihre Funktion als Nutzer testen.

## Anpassen der Oberfäche des Standardbenutzers

Zunächst meldet man sich als Standardbenutzer (user) an, um die Oberfläche anzupassen.

Progammstarter für das Programmmenü werden in Lubuntu in Textdateien mit der Endung .desktop organisiert. Diese Dateien liegen für alle installierten Anwendungen in Ordner /usr/share/applications. Auch im Homeverzeichnis eines Nutzers (z.B. user) können solche Dateien unter /home/user/.local/share liegen. Die Dateien in diesen Ordner werden zuerst ausgewertet.


Wenn man eine solche Datei ins Desktopverzeichnis eines Nutzers (/home/user/Desktop) kopiert, ensteht dort ein Programmstarter auf dem Desktop. Um das Programm zu starten muss man durch Rechtsklick das Programm noch als vertrauenswürdig einstufen.

**Desktop anpassen**

  * Rechtsklick auf dem Desktop -> Arbeitsflächeneinstellungen
  * Reiter Hintergrund -> Bild 2210-blue-logo.jpg
  * Reiter Erweitert -> alle Haken entfernen

**Verhalten bei USB-Sticks anpassen**

  * Dateimanager (pcmanfm-qt) öffnen 
  * Bearbeiten -> Einstellungen -> Datenträger -> Haken bei "Verfügbare Optionen ..." entfernen