# Lab 8.5.1: Configure DHCPv6

![Topology](Pasted%20image%2020250719185730.png)

### Devices used for the following lab:
- 2 Cisco ISR 4331 Routers
- 2 Cisco Catalyst 2960 Switches
- 2 PCs

### Addressing Table:
| Device | Interface | IP Address         | Prefix | Default Gateway |
| ------ | --------- | ------------------ | ------ | --------------- |
| R1     | G0/0/0    | 2001:db8:acad:2::1 | /64    |                 |
|        |           | fe80::1            |        |                 |
|        | G0/0/1    | 2001:db8:acad:1::1 | /64    |                 |
|        |           | fe80::1            |        |                 |
| R2     | G0/0/0    | 2001:db8:acad:2::2 | /64    |                 |
|        |           | fe80::1            |        |                 |
|        | G0/0/1    | 2001:db8:acad:3::1 | /64    |                 |
|        |           | fe80::1            |        |                 |
| PC1    | NIC       | DHCP               | DHCP   | DHCP            |
| PC2    | NIC       | DHCP               | DHCP   | DHCP            |

### Objectives:
1. Build the Network and Configure Basic Device Settings
2. Verify SLAAC address assignment from R1
3. Configure and verify a Stateless DHCPv6 Server on R1
4. Configure and verify a Stateful DHCPv6 Server on R1
5. Configure and verify a DHCPv6 Relay on R2

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
ipv6 unicast-routing
do clock set 19:05:00 Jul 19 2025
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
ipv6 unicast-routing
do clock set 19:05:00 Jul 19 2025
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
do clock set 19:05:00 Jul 19 2025
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
do clock set 19:05:00 Jul 19 2025
do copy run start
```

### Commands:

#### R1 Commands:
```ios
enable
conf t
int g0/0/0
ipv6 add
ipv6 add  link-local
no sh
description
exit
int g0/0/1
ipv6 add
ipv6 add  link-local
no sh
description
exit
ipv6 route ::0/
```

#### R2 Commands:
```ios
enable
conf t
int g0/0/0
ipv6 add
ipv6 add  link-local
no sh
description
exit
int g0/0/1
ipv6 add
ipv6 add  link-local
no sh
description
exit
```