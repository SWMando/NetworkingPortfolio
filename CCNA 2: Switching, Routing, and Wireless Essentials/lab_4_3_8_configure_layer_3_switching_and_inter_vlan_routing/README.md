# Lab 4.3.8: Configure Layer 3 Switching and Inter-VLAN Routing

![Topology](Pasted%20image%2020250704154257.png)

### Devices used for the following lab:
- 1 Cisco Catalyst 3650 Switch
- 3 Cisco Catalyst 2960 Switches
- 6 PCs
- DSL modem (Cloud)
- PT-Cloud (Cloud)
- 2 Cisco ISR 4331 Routers (Cloud)
- 1 Server (Cloud)

### Addressing Table:
| Device | Interface | IP Address          | Subnet Mask     | Default Gateway     |
| ------ | --------- | ------------------- | --------------- | ------------------- |
| MLS    | VLAN10    | 192.168.10.254<br>  | 255.255.255.0   |                     |
|        |           | 2001:db8:acad:10::1 | /64             |                     |
|        | VLAN20    | 192.168.20.254      | 255.255.255.0   |                     |
|        |           | 2001:db8:acad:20::1 | /64             |                     |
|        | VLAN30    | 192.168.30.254      | 255.255.255.0   |                     |
|        |           | 2001:db8:acad:30::1 | /64             |                     |
|        | VLAN99    | 192.168.99.254      | 255.255.255.0   |                     |
|        | G1/0/2    | 209.165.200.225     | 255.255.255.252 |                     |
|        |           | 2001:db8:acad:a::1  | /64             |                     |
| PC1    | NIC       | 192.168.10.1        | 255.255.255.0   | 192.168.10.254      |
| PC2    | NIC       | 192.168.20.1        | 255.255.255.0   | 192.168.20.254      |
| PC3    | NIC       | 192.168.30.1        | 255.255.255.0   | 192.168.30.254      |
| PC4    | NIC       | 192.168.10.2        | 255.255.255.0   | 192.168.10.254      |
|        |           | 2001:db8:acad:10::2 | /64             | 2001:db8:acad:10::1 |
| PC5    | NIC       | 192.168.20.2        | 255.255.255.0   | 192.168.20.254      |
|        |           | 2001:db8:acad:20::2 | /64             | 2001:db8:acad:20::1 |
| PC6    | NIC       | 192.168.30.2        | 255.255.255.0   | 192.168.30.254      |
|        |           | 2001:db8:acad:30::2 | /64             | 2001:db8:acad:30::1 |
| S1     | VLAN99    | 192.168.99.1        | 255.255.255.0   | 192.168.99.254      |
| S2     | VLAN99    | 192.168.99.2        | 255.255.255.0   | 192.168.99.254      |
| S3     | VLAN99    | 192.168.99.3        | 255.255.255.0   | 192.168.99.254      |

### Objectives:
1. Configure Layer 3 Switching
2. Configure Inter-VLAN Routing
3. Configure IPv6 Inter-VLAN Routing

We were provided only with `.pkt` file for this lab and the lab doc file includes neither the topology nor the configurations for the other devices. Additionally, the cloud in the topology is locked and can not be opened to see which devices are included there. So I decided to use imagination and make the lab a little bit more interesting.

![Cloud Cluster Topology](Pasted%20image%2020250705010429.png)

This is the topology of the `Cloud Cluster`.

### Only available configs from the `.pkt` lab file:

#### S1 Config:
```ios
enable
conf t
host S1
vlan 10
name Staff
exit
vlan 20
name Student
exit
vlan 30
name Family
exit
vlan 99
name Native
exit
int ran f0/1-24, g0/1-2
switchport mode access
switchport nonegotiate
sh
exit
int ran f0/1-2, g0/1
switchport mode trunk
switchport trunk native vlan 99
switchport trunk allowed vlan 10,20,30,99
no sh
exit
int vlan 1
sh
exit
int vlan 99
ip add 192.168.99.1 255.255.255.0
no sh
exit
ip default-gateway 192.168.99.254
do clock set 16:34:00 Jul 4 2025
do copy run start
```

#### S2 Config:
```ios
enable
conf t
host S2
vlan 10
name Staff
exit
vlan 20
name Student
exit
vlan 30
name Family
exit
vlan 99
name Native
exit
int ran f0/1-8
switchport mode access
switchport access vlan 10
no sh
exit
int ran f0/9-16
switchport mode access
switchport access vlan 20
no sh
exit
int ran f0/17-24
switchport mode access
switchport access vlan 30
no sh
exit
int ran g0/1-2
switchport mode access
switchport nonegotiate
sh
exit
int f0/1
switchport trunk native vlan 99
switchport trunk allowed vlan 10,20,30,99
switchport mode trunk
exit
int vlan 99
ip add 192.168.99.2 255.255.255.0
no sh
exit
ip default-gateway 192.168.99.254
do clock set 16:34:00 Jul 4 2025
do copy run start
```

#### S3 Config:
```ios
enable
conf t
host S3
vlan 10
name Staff
exit
vlan 20
name Student
exit
vlan 30
name Family
exit
vlan 99
name Native
exit
int ran f0/1-8
switchport mode access
switchport access vlan 10
no sh
exit
int ran f0/9-16
switchport mode access
switchport access vlan 20
no sh
exit
int ran f0/17-24
switchport mode access
switchport access vlan 30
no sh
exit
int ran g0/1-2
switchport mode access
switchport nonegotiate
sh
exit
int f0/2
switchport trunk native vlan 99
switchport trunk allowed vlan 10,20,30,99
switchport mode trunk
exit
interface vlan 99
ip add 192.168.99.3 255.255.255.0
exit
ip default-gateway 192.168.99.254
do clock set 16:34:00 Jul 4 2025
do copy run start
```

#### MLS Config:
```ios
enable
conf t
host MLS
int g1/0/1
switchport mode access
switchport nonegotiate
no sh
exit
ipv6 route ::/0 GigabitEthernet0/2 2001:DB8:ACAD:A::2
do clock set 16:34:00 Jul 4 2025
do copy run start
```

### Basic Configs of other devices:

#### ISPR1 (Cloud):
```ios
enable
conf t
host ISPR1
int g0/0/0
ip add 209.165.200.226 255.255.255.252
ipv6 add 2001:db8:acad:a::2/64
no sh
exit
int g0/0/1
ip add 198.51.100.1 255.255.255.252
no sh
router ospf 1
network 209.165.200.224 0.0.0.3 area 1
network 198.51.100.0 0.0.0.3 area 0
area 1 range 192.168.0.0 255.255.224.0
exit
do clock set 16:34:00 Jul 4 2025
do copy run start
```

### CloudR1 (Cloud):
```ios
enable
conf t
host CloudR1
int g0/0/1
ip add 198.51.100.2 255.255.255.252
no sh
exit
int g0/0/0
ip add 203.0.113.1 255.255.255.252
no sh
exit
router ospf 1
network 198.51.100.0 0.0.0.3 area 0
network 203.0.113.0 0.0.0.3 area 2
passive-interface g0/0/0
exit
do clock set 16:34:00 Jul 4 2025
do copy run start
```

#### Server (Cloud):
![Server IP configuration](Pasted%20image%2020250705005234.png)

![Web Server](Pasted%20image%2020250705005251.png)

### Commands

#### MLS Commands:
```ios
enable
conf t
int g1/0/2
no switchport
ip add 209.165.200.225 255.255.255.252
ip ospf 1 area 1
ipv6 add 2001:db8:acad:a::1/64
no sh
exit
vlan 10
name Staff
exit
vlan 20
name Student
exit
vlan 30
name Family
exit
vlan 99
name Native
exit
int g1/0/1
switchport mode trunk
switchport trunk native vlan 99
switchport trunk allowed vlan 10,20,30,99
switchport trunk encapsulate dot1q
exit
ip routing
ipv6 unicast-routing
int vlan 10
ip add 192.168.10.254 255.255.255.0
ipv6 add 2001:db8:acad:10::1/64
no sh
exit
int vlan 20
ip add 192.168.20.254 255.255.255.0
ipv6 add 2001:db8:acad:20::1/64
no sh
exit
int vlan 30
ip add 192.168.30.254 255.255.255.0
ipv6 add 2001:db8:acad:30::1/64
no sh
exit
int vlan 99
ip add 192.168.99.254 255.255.255.0
no sh
exit
router ospf 1
network 192.168.10.0 0.0.0.255 area 1
network 192.168.20.0 0.0.0.255 area 1
network 192.168.30.0 0.0.0.255 area 1
passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
exit
do copy run start
```