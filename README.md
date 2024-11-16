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

## Installation von Lubuntu

Zur Installation wurde die aktuell stabile Version 24.04.1 (https://lubuntu.me/downloads/) von Lubuntu verwendet. Eine Installationsanleitung findet man hier:

https://manual.lubuntu.me/stable/1/Installing_lubuntu.html

Bei der Installation wurde minimale Installation gewählt und ein Nutzer mit administrativen Rechten (sudo, Nutzername: admin) eingerichtet.

## Nachinstallation von Paketen

Für den Thin Client wird noch weitere Software benötigt:

  * Featherpad - ein einfacher Editor zum Bearbeiten der Scripte
  * Freerdp3 - der eigentliche RDP-Client
  * Zenity - eine GUI-Bibliothek für Shellscripte

```
sudo apt -y upgrade && sudo apt -y dist-upgrade
sudo apt install featherpad freerdp3-x11 freerdp3-wayland zenity
```

## Einrichten des Standardnutzers

