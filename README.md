# HomeFW

Voici les étapes pour créer HomeFW, un point d'accès sans fil avec parefeu intégré, basé sur Raspberry Pi 3. HomeFW se branche directement sur la box Internet et permet de créer un sous-réseau Ethernet isolé. Les appareils qui sont connectés à HomeFW peuvent accéder à Internet mais ne peuvent pas accéder aux terminaux connectés à la box. 
1) Télécharger la dernière version de Raspbian Lite sur raspbian.org. Flasher l'image sur une carte SD au moyen du logiciel Etcher.  
2) Installer Raspbian Lite puis, au premier démarrage, le mettre à niveau.
-> apt-get update && upgrade 
3) Installer tous les logiciels nécessaires:
-> apt-get install hostapd isc-dhcp-server dnsmasq iptables rcconf
