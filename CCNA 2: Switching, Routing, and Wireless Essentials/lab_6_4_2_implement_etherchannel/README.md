# Lab 6.4.2: Implement Etherchannel

![Toplogy](Pasted%20image%2020250706142837.png)

### Devices used for the following lab:
- 2 Cisco Catalyst 2960 Switches
- 2 PCs

### Addressing Table:
| Device | Interface | IP Address    | Subnet Mask   | Default Gateway |
| ------ | --------- | ------------- | ------------- | --------------- |
| S1     | VLAN 10   | 192.168.10.11 | 255.255.255.0 |                 |
| S2     | VLAN 10   | 192.168.10.12 | 255.255.255.0 |                 |
| PC1    | NIC       | 192.168.20.3  | 255.255.255.0 |                 |
| PC2    | NIC       | 192.168.20.4  | 255.255.255.0 |                 |

### VLAN Table:
| VLAN | Name        | Interface Assigned                                           |
| ---- | ----------- | ------------------------------------------------------------ |
| 10   | Management  | S1: VLAN 10<br>S2: VLAN 10                                   |
| 20   | Clients     | S1: F0/6<br>S2: F0/18                                        |
| 999  | Parking_Lot | S1: F0/3-5, F0/7-24, G0/1-2<br>S2: F0/3-17, F0/19-24, G0/1-2 |
| 1000 | Native      | NA                                                           |

### Objectives:
1. Build the Network and Configure Basic Device Settings
2. Create VLANs and Assign Switch Ports
3. Configure 802.1Q Trunks between the Switches
4. Implement and Verify an EtherChannel between the switches

### Basic Configs:

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

#### S1 Commands:
```ios
enable
conf t
vlan 10
name Management
exit
vlan 20
name Clients
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
int ran f0/3-5, f0/7-24, g0/1-2
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
int ran f0/1-2
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 10,20,1000
channel-group 1 mode active
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
name Clients
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
int ran f0/3-17, f0/19-24, g0/1-2
switchport mode access
switchport nonegotiate
switchport access vlan 999
sh
exit
int f0/18
switchport mode access
switchport nonegotiate
switchport access vlan 20
no sh
exit
int ran f0/1-2
switchport mode trunk
switchport nonegotiate
switchport trunk native vlan 1000
switchport trunk allowed vlan 10,20,1000
channel-group 1 mode active
exit
do copy run start
```
