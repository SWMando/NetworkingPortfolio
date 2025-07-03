# Lab 16.5.2: Configuring SSH and Securing Network Devices

![Topology](Pasted%20image%2020250624161836.png)
### Devices used for the following lab:
- 1 Cisco ISR 4331 Router
- 1 Cisco Catalyst 2960 Switch
- 1 PC

### Addressing Table:
| Device | Interface | IP Address   | Subnet Mask   | Default Gateway |
| ------ | --------- | ------------ | ------------- | --------------- |
| R1     | G0/0/1    | 192.168.1.1  | 255.255.255.0 | NA              |
| S1     | VLAN1     | 192.168.1.11 | 255.255.255.0 | 192.168.1.1     |
| PC1    | NIC       | 192.168.1.3  | 255.255.255.0 | 192.168.1.1     |

### Objectives:
The goal of this lab is to apply all knowledge gained through out CCNA 1 course and apply in here, additionally establish SSH Access and apply security measures:
1. Basic Device Config
2. SSH Access for Router
3. SSH Access for Switch
4. Basic Security Measures on Router
5. Verify Security Measures
6. Basic Security Measures on Switch

#### R1 Commands:
```ios
enable
conf t
host R1
banner motd #Authorized access only!#
int g0/0/1
ip add 192.168.1.1 255.255.255.0
no sh
exit
int g0/0/0
sh
exit
security passwords min-length 10
enable secret Cisco@12345
username admin secret Admin@12345
username SSHAdmin secret Admin@12345
ip domain-name ccna-lab.com
no ip domain lookup
crypto key gen rsa general-keys modulus 1024
login block-for 120 attempts 3 within 60
ip ssh version 2
line con 0
pass Console@12345
login
exec-t 5 0
logg s
exit
line aux 0
pass Auxline@12345
login
exec-t 5 0
logg s
exit
line vty 0 4
pass Vtyline@12345
login local
transport input ssh
exec-t 5 0
logg s
exit
service password-encryption
do copy run start
```

#### S1 Commands:
```ios
enable
conf t
host S1
banner motd #Authorized access only!#
int vlan 1
ip add 192.168.1.11 255.255.255.0
no sh
exit
int ran f0/1-4, f0/7-24, g0/1-2
sh
exit
security passwords min-length 10
enable secret Cisco@12345
username admin secret Admin@12345
username SSHAdmin secret Admin@12345
ip domain-name ccna-lab.com
no ip domain lookup
ip default-gateway 192.168.1.1
crypto key gen rsa general-keys modulus 1024
login block-for 120 attempts 3 within 60
ip ssh version 2
line con 0
pass Console@12345
login
exec-t 5 0
logg s
exit
line vty 0 15
pass Vtyline@12345
login local
transport input ssh
exec-t 5 0
logg s
exit
service password-encryption
do copy run start
```
