#networking 

ISP  Network 198.51.100.0/24
Between routers only two ips can be used
Net 1 - 198.51.100.0/25
Net 2 - 198.51.100.128/26
Net 3 - 198.51.100.192/27 - ISPR1-Clients
Net 4 - 198.51.100.224/28 - ISPR2-Clients
Net 5 - 198.51.100.240/30 - ISPR1-ISPR2
Net 6 - 198.51.100.244/30 - ISPR1-SRV1
Net 7 - 198.51.100.248/30
Net 8 - 198.51.100.252/30

ISPR1-Clients:
ISPR1 198.51.100.222
Clients DHCP

ISPR1-ISPR2:
ISPR1 198.51.100.241
ISPR2 198.51.100.242

ISPR1-SRV1:
ISPR1 198.51.100.245
SRV1 198.51.100.246

ISPR2-Clients:
ISPR2 198.51.100.238
Clients DHCP

### ISP Router 1
```ios
enable
conf t
no ip domain-lookup
host ISPR1
enable secret class
banner login #
**************************************************
*        Welcome to ISP Network                  *
*  Authorized Access Only!                       *
*  This system is monitored and audited.         *
*  Unauthorized access is strictly prohibited.   *
**************************************************
#
banner motd #
**************************************************
*        Welcome to ISP Network                  *
*  Authorized Access Only!                       *
*  This system is monitored and audited.         *
*  Unauthorized access is strictly prohibited.   *
**************************************************
#
username admin privilige 15 secret Admin@isp12345
username student secret Cisco@isp12345
crypto key gen rsa general-keys modulus 2048
login block-for 120 attempts 3 within 30 
ip ssh version 2
line con 0
login local
exec-t 3 0
logg s
exit
line aux 0
login local
exec-t 3 0
logg s
exit
line vty 0 4
login local
exec-t 3 0
logg s
transport input ssh
exit
int g0/0/0
description ISPR1-ISPR2
ip add 198.51.100.241 255.255.255.252
no sh
exit
int g0/0/1
description ISPR1-Clients
ip add 198.51.100.222 255.255.255.224
no sh
exit
ISPR1-SRV1
int g0/0/2
ip add 198.51.100.245 255.255.255.252
no sh
exit
int lo0
ip add 172.16.1.1 255.255.255.0
no sh
exit
router ospf 1
router-id 1.1.1.1
network 198.51.100.192 0.0.0.31 area 0
network 198.51.100.240 0.0.0.3 area 0
network 198.51.100.244 0.0.0.3 area 0
exit
```

### ISP Router 2
```ios
enable
conf t
no ip domain-lookup
host ISPR1
enable secret class
banner login #
**************************************************
*        Welcome to ISP Network                  *
*  Authorized Access Only!                       *
*  This system is monitored and audited.         *
*  Unauthorized access is strictly prohibited.   *
**************************************************
#
banner motd #
**************************************************
*        Welcome to ISP Network                  *
*  Authorized Access Only!                       *
*  This system is monitored and audited.         *
*  Unauthorized access is strictly prohibited.   *
**************************************************
#
username admin privilige 15 secret Admin@isp12345
username student secret Cisco@isp12345
crypto key gen rsa general-keys modulus 2048
login block-for 120 attempts 3 within 30 
ip ssh version 2
line con 0
login local
exec-t 3 0
logg s
exit
line aux 0
login local
exec-t 3 0
logg s
exit
line vty 0 4
login local
exec-t 3 0
logg s
transport input ssh
exit
int g0/0/0
description ISPR1-ISPR2
ip add 198.51.100.242 255.255.255.252
no sh
exit
int g0/0/1
description ISPR2-Clients
ip add 198.51.100.238 255.255.255.240
no sh
exit
router ospf 1
router-id 1.1.1.2
network 198.51.100.240 0.0.0.3 area 0
network 198.51.100.224 0.0.0.15 area 0
exit
ip helper-address 198.51.100.246
```