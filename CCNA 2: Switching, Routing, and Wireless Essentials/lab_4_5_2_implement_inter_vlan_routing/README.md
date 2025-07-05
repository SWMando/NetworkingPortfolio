# Lab 4.5.2: Implement Inter-VLAN Routing

![Topology](Pasted%20image%2020250705141052.png)

### Devices used for the following lab:
- 1 Cisco ISR 4331 Router
- 2 Cisco Catalyst 2960 Switches
- 2 PCs

### Addressing Table:
| Device | Interface   | IP Address    | Subnet Mask   | Default Gateway |
| ------ | ----------- | ------------- | ------------- | --------------- |
| R1     | G0/0/1.10   | 192.168.10.1  | 255.255.255.0 |                 |
|        | G0/0/1.20   | 192.168.20.1  | 255.255.255.0 |                 |
|        | G0/0/1.30   | 192.168.30.1  | 255.255.255.0 |                 |
|        | G0/0/1.1000 | NA            |               |                 |
| S1     | VLAN 10     | 192.168.10.11 | 255.255.255.0 | 192.168.10.1    |
| S2     | VLAN 10     | 192.168.10.12 | 255.255.255.0 | 192.168.10.1    |
| PC1    | NIC         | 192.168.20.3  | 255.255.255.0 | 192.168.20.1    |
| PC2    | NIC         | 192.168.30.3  | 255.255.255.0 | 192.168.30.1    |

### VLAN Table:
| VLAN | Name        | Interface Assigned                                           |
| ---- | ----------- | ------------------------------------------------------------ |
| 10   | Management  | S1: VLAN 10<br>S2: VLAN 10                                   |
| 20   | Sales       | S1: F0/6                                                     |
| 30   | Operations  | S2: F0/18                                                    |
| 999  | Parking_Lot | S1: F0/2-4, F0/7-24, G0/1-2<br>S2: F0/2-17, F0/19-24, G0/1-2 |
| 1000 | Native      | NA                                                           |

### Objectives:
1. Build the Network and Configure Basic Device Settings
2. Create VLANs and Assign Switch Ports
3. Configure an 802.1Q Trunk between the Switches
4. Configure Inter-VLAN Routing on the Router
5. Verify Inter-VLAN Routing is working

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
do clock set 14:25:00 Jul 5 2025
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
do clock set 14:25:00 Jul 5 2025
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
do clock set 14:25:00 Jul 5 2025
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
int g0/0/1.10
encapsulation dot1q 10
description VLAN10
ip add 192.168.10.1 255.255.255.0
no sh
exit
int g0/0/1.20
encapsulation dot1q 20
description VLAN20
ip add 192.168.20.1 255.255.255.0
no sh
exit
int g0/0/1.30
encapsulation dot1q 30
description VLAN30
ip add 192.168.30.1 255.255.255.0
no sh
exit
int g0/0/1.1000
encapsulation dot1q 1000 native
description Native
no sh
exit
do copy run start
```

#### S1 Commands:
```ios
enable
conf t
vlan 10
name Management
exit
vlan 20
name Sales
exit
vlan 30
name Operations
exit
vlan 999
name Parking_Lot
exit
vlan 1000
name Native
exit
int vlan 10
ip add 192.168.10.11 255.255.255.0
no sh
exit
ip default-gateway 192.168.10.1
int ran f0/2-4, f0/7-24, g0/1-2
switchport mode access
switchport nonegotiate
switchport access vlan 999
sh
exit
int f0/6
switchport mode access
switchport nonegotiate
switchport access vlan 20
no sh
exit
int f0/1
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 10,20,30,1000
no sh
exit
int f0/5
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 10,20,30,1000
no sh
exit
do copy run start
```

#### S2 Commands:
```ios
enable
conf t
vlan 10
name Management
exit
vlan 20
name Sales
exit
vlan 30
name Operations
exit
vlan 999
name Parking_Lot
exit
vlan 1000
name Native
exit
int vlan 10
ip add 192.168.10.12 255.255.255.0
no sh
exit
ip default-gateway 192.168.10.1
int ran f0/2-17, f0/19-24, g0/1-2
switchport mode access
switchport nonegotiate
switchport access vlan 999
sh
exit
int f0/18
switchport mode access
switchport nonegotiate
switchport access vlan 30
no sh
exit
int f0/1
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 10,20,30,1000
no sh
exit
do copy run start
```
