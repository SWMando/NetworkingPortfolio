# Lab 12.9.2: Configure IPv6 Addresses on Network Devices

![Topology](Pasted%20image%2020250618171610.png)
### Devices used for the following lab:
- 1 Cisco ISR 4331 Router
- 1 Cisco Catalyst 2960 Switch
- 2 PCs

### Addressing Table
| Device | Interface  | IP Address         | Prefix | Default Gateway |
| ------ | ---------- | ------------------ | ------ | --------------- |
| R1     | G0/0/0     | 2001:db8:acad:a::1 | /64    | NA              |
|        | link-local | fe80::1            |        |                 |
|        | G0/0/1     | 2001:db8:acad:1::1 | /64    | NA              |
|        | link-local | fe80::1            |        |                 |
| S1     | VLAN1      | 2001:db8:acad:1::b | /64    | NA              |
|        | link-local | fe80::b            |        |                 |
| PC1    | NIC        | 2001:db8:acad:1::3 | /64    | fe80::1         |
| PC2    | NIC        | 2001:db8:acad:a::3 | /64    | fe80::1         |

The goal of this lab is to use IPv6 addresses only provided in the lab file and apply to topology. To verify connectivity use ping tool.

#### R1 Commands:

```ios
enable
conf t
host R1
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
banner motd #Authorized access only!#
int g0/0/0
ipv6 add 2001:db8:acad:a::1/64
ipv6 add fe80::1 link-local
no sh
exit
int g0/0/1
ipv6 add 2001:db8:acad:1::1/64
ipv6 add fe80::1 link-local
no sh
exit
ipv6 unicast-routing
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
service password-ecnryption
banner motd #Authorized access only!#
int vlan 1
ipv6 add 2001:db8:acad:1::b/64
ipv6 add fe80::b link-local
no sh
exit
do copy run start
```