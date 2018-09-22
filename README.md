# HomeFW

Voici les étapes pour créer HomeFW, un point d'accès sans fil avec parefeu intégré, basé sur Raspberry Pi 3. HomeFW se branche directement sur la box Internet et permet de créer un sous-réseau Ethernet isolé. Les appareils qui sont connectés à HomeFW peuvent accéder à Internet mais ne peuvent pas accéder aux terminaux connectés à la box. 
1) Télécharger la dernière version de Raspbian Lite sur raspbian.org. Flasher l'image sur une carte SD au moyen du logiciel Etcher.  
2) Installer Raspbian Lite puis, au premier démarrage, le mettre à niveau.
  
> apt-get update && upgrade 

3) Installer tous les logiciels nécessaires:
  
> apt-get install hostapd isc-dhcp-server dnsmasq iptables rcconf

4) Télécharger les fichiers de configuration depuis GitHub

> git ...

5) Modifiez les fichiers suivants:

>/etc/hostapd/hostapd.conf

-----------------START------------------

interface=wlan1
driver=nl80211
ssid=IOT
hw_mode=g
channel=11
wpa=2
wpa_passphrase=password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
wpa_ptk_rekey=600
#macaddr_acl=0

-----------------END--------------------


> /etc/dhcp/dhcpd.conf

-----------------START------------------

#option domain-name "iot-firewall";
#option domain-name-servers 8.8.8.8

ddns-update-style none;
log-facility local7;

subnet 10.10.0.0 netmask 255.255.255.0 {
range 10.10.0.100 10.10.0.150;
default-lease-time 600;
max-lease-time 7200;
#option domain-name-servers 8.8.4.4;
option routers 10.10.0.1;
option subnet-mask 255.255.255.0;
interface wlan0;
}

-----------------END--------------------


> /etc/sysctl.conf

you should have the following line

-----------------START------------------

net.ipv4.ip_forward=1

-----------------END--------------------


> /etc/default/isc-dhcp-server

you should have the following line

-----------------START------------------

INTERFACESv4="wlan0"

-----------------END--------------------


> /etc/default/hostapd

you should have the following line

-----------------START------------------

DEAMON_CONF="/etc/hostapd/hostapd.conf"

-----------------END--------------------


> /etc/default/dnsmasq

you should have the following line

-----------------START------------------

ENABLED=1

-----------------END--------------------


> /etc/network/interfaces

-----------------START------------------

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto eth0

iface eth0 inet dhcp
#wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp

#########################
# IP ADDRESS FOR IOT FW #
#########################
allow-hotplug wlan0
auto wlan0
iface wlan0 inet static
address 10.10.0.1
netmask 255.255.255.0

-----------------END--------------------

