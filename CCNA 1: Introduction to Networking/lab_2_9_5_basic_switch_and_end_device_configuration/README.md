# Lab 2.9.5: Basic Switch and End Device Configuration

![Topology](Pasted%20image%2020250617145956.png)

### Devices used for the following lab:
* 2 Cisco Catalyst 2960 Switches
* 2 PCs

### Addressing Table

| Device | Interface | IP Address   | Subnet Mask   |
| ------ | --------- | ------------ | ------------- |
| S1     | VLAN1     | 192.168.1.1  | 255.255.255.0 |
| S2     | VLAN1     | 192.168.1.2  | 255.255.255.0 |
| PC1    | NIC       | 192.168.1.10 | 255.255.255.0 |
| PC2    | NIC       | 192.168.1.11 | 255.255.255.0 |

The goal of this lab is to make basic configuration of Switches and End devices, verify the connectivity via the ping tool.
#### S1 Commands
```ios
enable
configuration terminal
hostname S1
no ip domain-lookup
line con 0
password cisco
login
exit
line vty 0 15
password cisco
login
exit
enable secret class
interface vlan 1
ip address 192.168.1.1 255.255.255.0
no shutdown
exit
banner motd #Attention! Authorized access only!#
exit
copy running-config startup-config
```

#### S2 Commands
```ios
enable
configuration terminal
hostname S2
no ip domain-lookup
line con 0
password cisco
login
exit
line vty 0 15
password cisco
login
exit
enable secret class
interface vlan 1
ip address 192.168.1.2 255.255.255.0
no shutdown
exit
banner motd #Attention! Authorized access only!#
exit
copy running-config startup-config
```
