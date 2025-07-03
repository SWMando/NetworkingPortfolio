# Lab 11.10.2: Design and Implement VLSM Addressing Scheme

![Topology](Pasted%20image%2020250618004838.png)
### Devices used for the following lab:
* 2 Cisco ISR 4331 Routers (With Internet access)
* 2 Cisco Catalyst 2960 Switches

### Needed hosts:
- BR1 LAN: 40 hosts
- BR1-BR2 Link: 2 hosts
- BR2 LAN: 25 hosts
- BR2 IoT LAN (Future): 5 hosts
- BR2 CCTV LAN (Future): 4 hosts
- BR2 HVAC C2LAN (Future): 4 hosts

### VLSM

We are given a network 192.168.33.128/25 to work with

| LAN                     | Needed Hosts | Network        | Subnet Mask     | Broadcast      | Usable Hosts |
| ----------------------- | ------------ | -------------- | --------------- | -------------- | ------------ |
| BR1 LAN                 | 40           | 192.168.33.128 | 255.255.255.192 | 192.168.33.191 | 62           |
| BR2 LAN                 | 25           | 192.168.33.192 | 255.255.255.224 | 192.168.33.223 | 30           |
| BR2 IoT LAN (Future)    | 5            | 192.168.33.224 | 255.255.255.248 | 192.168.33.231 | 6            |
| BR2 CCTV LAN (Future)   | 4            | 192.168.33.232 | 255.255.255.248 | 192.168.33.239 | 6            |
| BR2 HVAC C2LAN (Future) | 4            | 192.168.33.240 | 255.255.255.248 | 192.168.33.247 | 6            |
| BR1-BR2 Link            | 2            | 192.168.33.248 | 255.255.255.252 | 192.168.33.251 | 2            |

### Addressing table:
| Device | Interface | IP Address     | Subnet Mask     | Default Gateway |
| ------ | --------- | -------------- | --------------- | --------------- |
| BR1    | G0/0/0    | 192.168.33.249 | 255.255.255.252 | NA              |
|        | G0/0/1    | 192.168.33.129 | 255.255.255.192 | NA              |
| BR2    | G0/0/0    | 192.168.33.250 | 255.255.255.252 | NA              |
|        | G0/0/1    | 192.168.33.193 | 255.255.255.224 | NA              |
| S1     | VLAN1     | 192.168.33.130 | 255.255.255.192 | 192.168.33.129  |
| S2     | VLAN1     | 192.168.33.194 | 255.255.255.224 | 192.168.33.193  

The goal of this lab is to practice VLSM (*Variable Length Subnet Mask*), applying it to topology and testing the connectivity via the ping. This lab is related to the Chapter 11, so the routing is not covered yet. So the ping between S1 and S2 will not work. However, I know routing and all needed to be done is the following:

#### BR1 Commands:
```ios
enable
conf t
ip route 192.168.33.192 255.255.255.224 g0/0/0 192.168.33.250
```

I used a full path for routing, by including both the local interface of the BR1 and the next-hop ip address of the BR2

#### BR2 Commands
```ios
enable
conf t
ip route 192.168.33.128 255.255.255.192 g0/0/0
```

However, writing just the local interface of the router or just the next-hop ip address is enough as the topology is very simple, and this just helps to improve the speed of routing table lookups.