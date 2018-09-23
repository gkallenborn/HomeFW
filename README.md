# HomeFW

Voici les étapes pour créer HomeFW, un point d'accès sans fil avec parefeu intégré, basé sur Raspberry Pi 3. HomeFW se branche directement sur la box Internet et permet de créer un sous-réseau Ethernet isolé. Les appareils qui sont connectés à HomeFW peuvent accéder à Internet mais ne peuvent pas accéder aux terminaux connectés à la box. 
1) Télécharger la dernière version de Raspian sur le site raspbian.org. Flasher l'image sur une carte microSD (min 16 Go) au moyen du logiciel Etcher.  

2) Installez Raspbian puis, au premier démarrage, le mettre à niveau.
  
`apt-get update && apt-get upgrade` 

3) Installez tous les logiciels nécessaires:
  
`apt-get install hostapd isc-dhcp-server dnsmasq iptables rcconf git`

4) Téléchargez les fichiers de configuration depuis GitHub:

`git ...`

5) Modifiez les fichiers de configuration tel que indiqué dans configurations.txt.

6) Changez le mot de passe de votre Raspberry Pi 3:

`passwd`

7) Activez le démarrage automatique du service SSH, ce qui vous permettra d'accéder à distance au Rasperry Pi 3 depuis le réseau de la box:

`rcconf`

8) Rendez le fichier firewall exécutable, puis exécutez le:

```
chmod +x firewall.sh
sudo ./firewall.sh
```

