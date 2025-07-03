# Lab 1.6.2: Configure Basic Router Settings

![Topology](Pasted%20image%2020250702224622.png)

### Devices used for the following lab:
- 1 Cisco ISR 4331 Router
- 1 Cisco Catalyst 2960 Switch
- 2 PCs

### Addressing Table:
| Device | Interface | IP Address          | Subnet Mask   | Default Gateway |
| ------ | --------- | ------------------- | ------------- | --------------- |
| R1     | G0/0/0    | 192.168.0.1         | 255.255.255.0 |                 |
|        |           | 2001:db8:acad::1    | /64           |                 |
|        |           | fe80::1             |               |                 |
|        | G0/0/1    | 192.168.1.1         | 255.255.255.0 |                 |
|        |           | 2001:db8:acad:1::1  | /64           |                 |
|        |           | fe80::1             |               |                 |
|        | Loopback  | 10.0.0.1            | 255.255.255.0 |                 |
|        |           | 2001:db8:acad:2::1  | /64           |                 |
|        |           | fe80::1             |               |                 |
| PC1    | NIC       | 192.168.1.10        | 255.255.255.0 | 192.168.1.1     |
|        |           | 2001:db8:acad:1::10 | /64           | fe80::1         |
| PC2    | NIC       | 192.168.0.10        | 255.255.255.0 | 192.168.0.1     |
|        |           | 2001:db8:acad::10   | /64           | fe80::1         |

### Objectives:
1. Assign static IPv4 and IPv6 information to the PC interfaces.
2. Configure basic router settings.
3. Configure the router for SSH.
4. Verify network connectivity.

#### R1 Commands:
```ios
enable
conf t
host R1
banner motd #Authorized access only!#
no ip domain lookup
ip domain name ccna-lab.com
ipv6 unicast-routing
security passwords min-length 12
enable secret Ciscoexec@12345
username SSHAdmin secret Admin@12345
line con 0
pass Ciscocon@12345
login
logg s
exec-t 4 0
exit
line aux 0
pass Ciscoaux@12345
login
logg s
exec-t 4 0
exit
line vty 0 4
pass Ciscovty@12345
login
logg s
exec-t 4 0
transport input ssh
exit
service password-encryption
crypto key gen rsa general-keys modulus 1024
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
int lo0
ip add 10.0.0.1 255.255.255.0
ipv6 add 2001:db8:acad:2::1/64
ipv6 add fe80::1 link-local
no sh
exit
login block-for 120 attempts 3 within 60
do clock set 23:13:00 Jul 2 2025
do copy run start
```
