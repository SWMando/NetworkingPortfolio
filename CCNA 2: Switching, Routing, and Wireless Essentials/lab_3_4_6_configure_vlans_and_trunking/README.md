# Lab 3.4.6: Configure VLANs and Trunking

![Topology](Pasted%20image%2020250703165132.png)

### Devices used for the following lab:
- 2 Cisco Catalyst 2960 Switches
- 2 PCs

### Addressing Table
| Device | Interface | IP Address   | Subnet Mask   | Default Gateway |
| ------ | --------- | ------------ | ------------- | --------------- |
| S1     | VLAN 1    | 192.168.1.11 | 255.255.255.0 |                 |
| S2     | VLAN 1    | 192.168.1.12 | 255.255.255.0 |                 |
| PC1    | NIC       | 192.168.10.3 | 255.255.255.0 |                 |
| PC2    | NIC       | 192.168.10.4 | 255.255.255.0 |                 |

### Objectives:
1. Build the Network and Configure Basic Device Settings.
2. Create VLANs and Assign Switch Ports.
3. Maintain VLAN Port Assignments and the VLAN Database.
4. Configure an 802.1Q Trunk between the Switches.
5. Delete the VLAN Database

**Note: AT THE END OF THE LAB IT ASKS TO DELETE VLAN DATABASE. IN ORDER TO SHOW THE END RESULT THE COMMAND `delete vlan.dat` WAS NOT RUN!**

### Basic Configs

#### S1:
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
int vlan 1
ip add 192.168.1.11 255.255.255.0
no sh
exit
int ran f0/2-5, f0/7-24, g0/1-2
sh
exit
do clock set 17:03:00 Jul 3 2025
do copy run start
```

#### S2:
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
int vlan 1
ip add 192.168.1.12 255.255.255.0
no sh
exit
int ran f0/2-17, f0/19-24, g0/1-2
sh
exit
do clock set 17:03:00 Jul 3 2025
do copy run start
```

### Lab Commands:

#### S1:
```ios
conf t
vlan 10
name Operations
exit
vlan 20
name Parking_Lot
exit
vlan 99
name Management
exit
vlan 1000
name Native
exit
int f0/6
switchport mode access
switchport access vlan 10
exit
int vlan 1
no ip address
exit
int vlan 99
ip add 192.168.1.11 255.255.255.0
no sh
exit
int ran f0/11-24
switchport mode access
switchport access vlan 99
exit
int ran f0/11,f0/21
no switchport access vlan
switchport access vlan 10
exit
int f0/24
no switchport access vlan
switchport access vlan 30
exit
no vlan 30
int f0/24
no switchport access vlan
exit
int f0/1
switchport mode dynamic desirable
exit
int f0/1
switchport mode trunk
switchport trunk native vlan 1000
end
```

#### S2:
```ios
conf t
vlan 10
name Operations
exit
vlan 20
name Parking_Lot
exit
vlan 99
name Management
exit
vlan 1000
name Native
exit
int f0/18
switchport mode access
switchport access vlan 10
exit
int vlan 1
no ip address
exit
int vlan 99
ip add 192.168.1.12 255.255.255.0
no sh
exit
int f0/1
switchport mode trunk
switchport trunk native vlan 1000
end
```
