#!/bin/bash
# Flushing all rules
iptables -F FORWARD
iptables -F INPUT
iptables -F OUTPUT
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Accept estalished TCP packets
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow incoming SSH from main home network
iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW -j ACCEPT

# Allow DNS outbound
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT

# Allow HTTP outbound
iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT

# Allow HTTPS outbound
iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT

# Enable NAT
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o eth0 -j MASQUERADE

# Allow IOT to internet but not to main home network
iptables -A FORWARD -s 10.10.0.0/24 -d 10.8.0.0/24 -j DROP
iptables -A FORWARD -s 10.10.0.0/24 -d 192.168.0.0/24 -j DROP
iptables -A FORWARD -o eth0 -s 10.10.0.0/24 -j ACCEPT
