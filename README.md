# Einrichten eines RDP-Thin-Clients auf der Basis von Lubuntu

In diesem Repository wird beschrieben, wie man einen RDP-Thin-Client auf der Basis von Lubuntu einrichten kann. Die notwendigen Scripte und Konfigurationsdateien werden zur Verfügung gestellt.

Der Thin Client hat einen administrativen Nutzer (admin) mit sudo-Rechten und einen Standardnutzer (user) durch den die Anmeldung am Terminalserver erfolgen. Nach Booten des Systems soll der User automatisch angemeldet werden. Dort hat er nur die folgenden Möglichkeiten:

  * Anmelden am Terminalserver
  * Herunterfahren des Systems
  * Neustart des Systems

Das Starten anderer Anwendungen bzw. das Verändern der Konfiguration des Systems soll nicht möglich oder durch Passwort geschützt sein. Nach dem Neustart sollen sich die Nutzereinstellung wieder im ursprünglichen Zustand befinden.

## Inhaltsverzeichnis


- [Installation von Lubuntu](#installation-von-lubunt)

## Installation von Lubuntu
