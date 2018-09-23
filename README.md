# HomeFW

Voici les étapes pour créer HomeFW, un point d'accès Wi-Fi avec parefeu intégré, basé sur Raspberry Pi 3. HomeFW se branche directement en filaire sur la box Internet et permet de créer un sous-réseau Ethernet isolé et sans fil. Les appareils qui sont connectés à HomeFW peuvent accéder à Internet mais ne peuvent pas accéder aux terminaux connectés à la box, et inversement. 
1) Téléchargez [la dernière version de Raspian](https://www.raspberrypi.org/downloads/). Flashez l'image sur une carte microSD (min 16 Go) au moyen du logiciel [Etcher](https://etcher.io) qui est très facile d'usage.  

2) Au premier démarrage, le système vous demandera de choisir la langue et de changer de mot de passe. Choisissez en un qui soit fort, car il servira plus tard à initier des connexions SSH. Le système va ensuite se mettre automatique à jour. Cela peut prendre un peu de temps. Allez vous préparer un café.

3) Ouvrez une fenêtre de commandes et téléchargez les fichiers de configurations dans un nouveau dossier intitulé HomeFW:

`git clone https://github/gkallenborn/HomeFW HomeFW`

4) Installez tous les logiciels nécessaires:
  
`sudo apt-get install hostapd isc-dhcp-server dnsmasq iptables rcconf`

5) Modifiez les fichiers de configuration tel que indiqué dans configurations.txt:

```
sudo nano /etc/hostapd/hostapd.conf
sudo nano /etc/dhcp/dhcpd.conf
sudo nano /etc/sysctl.conf
sudo nano /etc/default/isc-dhcp-server
sudo nano /etc/default/hostapd
sudo nano /etc/default/dnsmasq
sudo nano /network/interfaces
```

6) Activez le démarrage automatique du service SSH, ce qui vous permettra d'accéder à distance au Rasperry Pi 3 depuis le réseau de la box:

`rcconf`

7) Rendez le fichier firewall exécutable, puis exécutez le:

```
chmod +x firewall.sh
sudo ./firewall.sh
```

