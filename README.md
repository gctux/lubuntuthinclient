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
- [Installation der Scripte für den Standardnutzer](#installation-der-scripte-für-den-standardnutzer)
- [Anpassen der Oberfäche des Standardbenutzers](#anpassen-der-oberfäche-des-standardbenutzers)
- [Konfiguration des Autologins für User](#konfiguration-des-autologins-für-user)

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

Progammstarter für das Programmmenü werden in Lubuntu in Textdateien mit der Endung .desktop organisiert. Diese Dateien liegen für alle installierten Anwendungen in Ordner /usr/share/applications. Auch im Homeverzeichnis eines Nutzers (z.B. user) können solche Dateien unter /home/user/.local/share/applications liegen. Die Dateien in diesen Ordner werden zuerst ausgewertet.


Wenn man eine solche Datei ins Desktopverzeichnis eines Nutzers (/home/user/Desktop) kopiert, ensteht dort ein Programmstarter auf dem Desktop. Um das Programm zu starten muss man durch Rechtsklick das Programm noch als vertrauenswürdig einstufen.

**Desktop anpassen**

  * Rechtsklick auf dem Desktop -> Arbeitsflächeneinstellungen
  * Reiter Hintergrund -> Bild 2210-blue-logo.jpg
  * Reiter Erweitert -> alle Haken entfernen
  * die Datei Windows-Terminalserver.desktop nach /home/user/Desktop kopieren
  * Rechtsklick -> Haken bei: Dieser ausführbaren Datei vertrauen

**Verhalten bei USB-Sticks anpassen**

  * Dateimanager (pcmanfm-qt) öffnen 
  * Bearbeiten -> Einstellungen -> Datenträger -> Haken bei "Verfügbare Optionen ..." entfernen

**Tastenkombinationen anpassen**

  * Startmenü -> Einstellungen -> LXQT-Systemeinstellung -> Kurzbefehl Konfiguration
  * Launch Terminal ändern -> Befehl: /usr/local/bin/startterminal.sh
  * alle anderen Kurzbefehle deaktivieren

**Leiste anpassen**
  * Rechtsklick auf Leiste -> Leiste konfigurieren
  * Folgende Eiträge entfernen:
    * Arbeitsflächenumschalter
    * Schnellstarter
    * Arbeitsfläche anzeigen
  * Rechtsklick auf Leiste -> Leiste sperren

**Anwendungsmenü anpassen**

Um einen Menüpunkt im Anwendungsmenü zu verstecken, kopiert man die entsprechende Desktopdatei von /usr/share/applications nach /home/user/.local/share/applications und fügt bei allen Desktopdateien außer lxqt-shutdown.desktop und lxqt-reboot.desktop die Zeile 

```
NoDesktop=true
```
hinzu. Wenn das Verzeichnis nicht existiert, muss es angelegt werden. Weiterhin kopiert man die Datei Windows-Terminalserver.desktop nach /home/user/.local/share/applications, damit sie im Menü ersccheint.

**Schreibschutz für die Konfigurationsdateien**

Damit der Nutzer User die Konfigurationsdateien nicht ändern kann, übergeben wir die Eigentümerschaft an Admin und machen damit die Dateien für User nur lesbar.

```
sudo chown -R admin:admin /home/user/Desktop
sudo chown -R admin:admin /home/user/.local/share/applications
sudo chown -R admin:admin /home/user/.config/lxqt
sudo chown -R admin:admin /home/user/.config/pcmanfm-qt
```

## Konfiguration des Autologins für User

Beim Start dees Thin Clients soll User automatisch angemeldet werden. 

  * Als Admin: Anwendungsmenü -> Zubehör -> SDDM Konfiguration
  * Bei "Benutzername für automatische Anmeldung" user eintragen
  * Speichern und mit Admin-Passwort bestätigen
  * durch Neustart testen

Um sich als Standartbenutzer abzumelden, startet man mit Strg+Alt+t ein Terminal, gibt das Passwort für das Script ein und gibt im Terminal den Befehl

```
lxqt-leave --logout
```
ein.

## Einrichten eines Backup- und eiens Restorescripts

Mit dem Backupsscript soll der aktuelle Zustand des Nutzerverzeichnisses gesichert werden. Das Restorescript spielt das Verzeichnis bei jedem Systemtemstart wieder ein. In den Scripten wird rsync verwendet, so dass die Rechte und die Besitzverhältnisse erhalten bleiben.

Die beiden Scriptdateien backup_userhome.sh und restore_userhome.sh können von diesem Repository heruntergeladen werden. Hier ist ihr Inhalt:

backup_userhome.sh:

```
#!/bin/bash -e

rsync -a /home/user/ /home/admin/Backup/user/
```

restore_userhome.sh:

```
#!/bin/bash -e

rsync -a --delete /home/admin/Backup/user/ /home/user/
```