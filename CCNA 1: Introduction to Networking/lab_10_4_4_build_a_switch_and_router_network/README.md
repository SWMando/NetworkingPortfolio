# Lab 10.4.4: Build a Switch and Router Network

![Topology](Pasted%20image%2020250617152531.png)

### Devices used for the following lab:
* 1 Cisco ISR 4331 Router (With Internet access)
* 1 Cisco Catalyst 2960 Switch
* 2 PCs

### Addressing Table:
| Device | Interface  | IP Address         | Subnet Mask   | Default Gateway |
| ------ | ---------- | ------------------ | ------------- | --------------- |
| R1     | G0/0/0     | 192.168.0.1        | 255.255.255.0 | NA              |
|        |            | 2001:db8:acad::1   | /64           | NA              |
|        | link-local | fe80::1            | NA            | NA              |
|        | G0/0/1     | 192.168.1.1        | 255.255.255.0 | NA              |
|        |            | 2001:db8:acad:1::1 | /64           | NA              |
|        | link-local | fe80::1            | NA            | NA              |
| S1     | VLAN1      | 192.168.1.2        | 255.255.255.0 |                 |
|        |            | 2001:db8:acad:1::2 | /64           | NA              |
|        | link-local | fe80::2            |               | NA              |
| PC1    | NIC        | 192.168.1.3        | 255.255.255.0 | 192.168.1.1     |
|        |            | 2001:db8:acad:1::3 | /64           | fe80::1         |
| PC2    | NIC        | 192.168.0.3        | 255.255.255.0 | 192.168.0.1     |
|        |            | 2001:db8:acad::3   | /64           | fe80::1         |

The goal of this lab is to make basic configuration of all devices and verify the connectivity via the ping tool.

#### R1 Commands
```ios
enable
conf t
host R1
no ip domain-lookup
ipv6 unicast-routing
enable secret class
line con 0
pass cisco
login
logg s
exit
line aux 0
pass cisco
login
logg s
exit
line vty 0 4
pass cisco
login
logg s
exit
service password-encryption
banner motd # Authorized access only!#
int g0/0/0
ip add 192.168.0.1 255.255.255.0
ipv6 add 2001:db8:acad::1/64
ipv6 add fe80::1 link-local
no sh
exit
int g0/0/1
ip add 192.168.1.1 255.255.255.0
ipv6 add 2001:db8:acad:1::1/64
ipv6 add fe80::1 link-local
no sh
exit
do clock set 2:52:00 June 12 2025
do copy run start
```

#### S1 Commands
```ios
enable
conf t
sdm prefer dual-ipv4-and-ipv6 default
do copy run start
do reload
enable
conf t
host S1
no ip domain-lookup
enable secret class
line con 0
pass cisco
login
logg s
exit
line vty 0 15
pass cisco
login
logg s
exit
service password-encryption
banner motd # Authorized access only!#
int vlan 1
ip add 192.168.1.2 255.255.255.0
ipv6 add 2001:db8:acad:1::2/64
ipv6 add fe80::2 link-local
no sh
exit
ip default-gateway 192.168.1.1
do clock set 2:56:00 June 12 2025
do copy run start
```
