# Lab 7.4.2: Implement DHCPv4

![Topology](Pasted%20image%2020250717175554.png)

### Devices used for the following lab:
- 2 Cisco ISR 4331 Routers
- 2 Cisco Catalyst 2960 Switches
- 2 PCs

### Addressing Table:
| Device | Interface   | IP Address   | Subnet Mask     | Default Gateway |
| ------ | ----------- | ------------ | --------------- | --------------- |
| R1     | G0/0/0      | 10.0.0.1     | 255.255.255.252 |                 |
|        | G0/0/1      | NA           | NA              |                 |
|        | G0/0/1.100  | 192.168.1.1  | 255.255.255.192 |                 |
|        | G0/0/1.200  | 192.168.1.65 | 255.255.255.224 |                 |
|        | G0/0/1.1000 | NA           | NA              |                 |
| R2     | G0/0/0      | 10.0.0.2     | 255.255.255.252 |                 |
|        | G0/0/1      | 192.168.1.97 | 255.255.255.240 |                 |
| S1     | VLAN 200    | 192.168.1.66 | 255.255.255.224 | 192.168.1.65    |
| S2     | VLAN 1      | 192.168.1.98 | 255.255.255.240 | 192.168.1.97    |
| PC1    | NIC         | DHCP         | DHCP            | DHCP            |
| PC2    | NIC         | DHCP         | DHCP            | DHCP            |

### VLAN Table:
| VLAN | Name        | Interface Assigned          |
| ---- | ----------- | --------------------------- |
| 1    | NA          | S2: F0/18                   |
| 100  | Clients     | S1: F0/6<br>                |
| 200  | Management  | S1: VLAN 200<br>            |
| 999  | Parking_Lot | S1: F0/1-4, F0/7-24, G0/1-2 |
| 1000 | Native      | NA                          |

### Objectives:
1. Build the Network and Configure Basic Device Settings
2. Configure and verify two DHCPv4 Servers on R1
3. Configure and verify a DHCP Relay on R2

### Basic Configs:

#### R1 Config:
```ios
enable
conf t
host R1
banner motd #Authorized access only!#
no ip domain lookup
enable secret class
line con 0
pass cisco
login
logg s
exec-t 5 0
exit
line aux 0
pass cisco
login
logg s
exec-t 5 0
exit
line vty 0 4
pass cisco
login
logg s
exec-t 5 0
exit
service password-encryption
do clock set 18:20:00 Jul 17 2025
do copy run start
```

#### R2 Config:
```ios
enable
conf t
host R2
banner motd #Authorized access only!#
no ip domain lookup
enable secret class
line con 0
pass cisco
login
logg s
exec-t 5 0
exit
line aux 0
pass cisco
login
logg s
exec-t 5 0
exit
line vty 0 4
pass cisco
login
logg s
exec-t 5 0
exit
service password-encryption
do clock set 18:20:00 Jul 17 2025
do copy run start
```

#### S1 Config:
```ios
enable
conf t
host S1
banner motd #Authorized access only!#
no ip domain lookup
enable secret class
line con 0
pass cisco
login
logg s
exec-t 5 0
exit
line vty 0 15
pass cisco
login
logg s
exec-t 5 0
exit
service password-encryption
do clock set 18:20:00 Jul 17 2025
do copy run start
```

#### S2 Config:
```ios
enable
conf t
host S2
banner motd #Authorized access only!#
no ip domain lookup
enable secret class
line con 0
pass cisco
login
logg s
exec-t 5 0
exit
line vty 0 15
pass cisco
login
logg s
exec-t 5 0
exit
service password-encryption
do clock set 18:20:00 Jul 17 2025
do copy run start
```

### Commands:

#### R1 Commands:
```ios
enable
conf t
int g0/0/1
no sh
exit
int g0/0/1.100
encapsulation dot1q 100
ip add 192.168.1.1 255.255.255.192
description VLAN100
no sh
exit
int g0/0/1.200
encapsulation dot1q 200
ip add 192.168.1.65 255.255.255.224
description VLAN200
no sh
exit
int g0/0/1.1000
encapsulation dot1q 1000 native
description Native
no sh
exit
int g0/0/0
ip add 10.0.0.1 255.255.255.252
no sh
exit
ip route 0.0.0.0 0.0.0.0 10.0.0.2
ip dhcp excluded-address 192.168.1.1 192.168.1.5
ip dhcp excluded-address 192.168.1.97 192.168.1.101
ip dhcp pool LAN1.1
default-router 192.168.1.1
network 192.168.1.0 255.255.255.192
domain-name ccna-lab.com
exit
ip dhcp pool R2_Client_LAN
default-router 192.168.1.97
network 192.168.1.96 255.255.255.240
domain-name ccna-lab.com
exit
do copy run start
```

**Note:** In Packet Tracer there is no lease time command, but for this lab the command is going to be `lease 2 12 30` which will let clients to lease an ip address for 2 days 12 hours and 30 minutes
#### R2 Commands:
```ios
enable
conf t
int g0/0/1
ip add 192.168.1.97 255.255.255.240
no sh
exit
int g0/0/0
ip add 10.0.0.2 255.255.255.252
no sh
exit
ip route 0.0.0.0 0.0.0.0 10.0.0.1
int g0/0/1
ip helper-address 10.0.0.1
exit
do copy run start
```

#### S1 Commands:
```ios
enable
conf t
vlan 100
name Clients
exit
vlan 200
name Management
exit
vlan 999
name Parking_Lot
exit
vlan 1000
name Native
exit
int vlan 200
ip add 192.168.1.66 255.255.255.224
no sh
exit
ip default-gateway 192.168.1.65
int ran f0/1-4, f0/7-24, g0/1-2
switchport mode access
switchport nonegotiate
switchport access vlan 999
sh
exit
int f0/6
switchport mode access
switchport nonegotiate
switchport access vlan 100
no sh
exit
int f0/5
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 100,200,1000
exit
do copy run start
```

#### S2 Commands:
```ios
enable
conf t
int vlan 1
ip add 192.168.1.98 255.255.255.240
no sh
exit
ip default-gateway 192.168.1.97
int ran f0/1-4, f0/6-17, f0/19-24, g0/1-2
sh
exit
do copy run start
```