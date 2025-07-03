# Lab 3.7.10: Resolving DNS names

![Topology](Pasted%20image%2020250617151150.png)

### Devices used for the following lab:
* 1 Cisco ISR 4331 Router (With Internet access)
* 1 Cisco Catalyst 2960 Switch
* 2 PCs

### Addressing Table:
| Device | Interface | IP Address      | Subnet Mask     |
| ------ | --------- | --------------- | --------------- |
| R1     | G0/0/0    | 192.168.1.1     | 255.255.255.0   |
|        | G0/0/1    | 209.165.200.225 | 255.255.255.252 |
| S1     | VLAN1     | 192.168.1.2     | 255.255.255.0   |
| PC1    | NIC       | DHCP            |                 |
| PC2    | NIC       | DHCP            |                 |

The goal of this lab is to practice nslookup tool and try to resolve the following domain names:
1. www.google.com
2. yahoo.com
3. www.cisco.com

To simulate the internet configuration here are the configuration commands on R1:
```ios
enable
conf t
host R1
int g0/0/0
description LAN
ip address 192.168.1.1 255.255.255.0
ip nat inside
no sh
exit
int g0/0/1
description WAN
ip address 209.165.200.225 255.255.255.252
ip nat outside
no sh
exit
ip access-list standard NAT
permit 192.168.1.0 0.0.0.255
exit
ip nat inside source list NAT interface GigabitEthernet0/0/1 overload
ip domain-name cisco.com
ip dhcp excluded-address 192.168.1.1 192.168.1.10
ip dhcp pool LAN
network 192.168.1.0 255.255.255.0
default-router 192.168.1.1
dns-server 209.165.200.226
exit
```

Here is how the topology looks in Packet Tracer:

![Topology](Pasted%20image%2020250617152123.png)

And here are the configurations of the Web Server:
![Topology](Pasted%20image%2020250617152218.png)
![Topology](Pasted%20image%2020250617152258.png)
