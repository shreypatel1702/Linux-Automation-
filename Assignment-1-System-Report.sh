#!/bin/bash

# Gather System Information
HOSTNAME=$(hostname)
OS=$(source /etc/os-release && echo $PRETTY_NAME)
UPTIME=$(uptime -p)

# Gather Hardware Information
CPU=$(lshw -class processor | grep "product" | head -1)
RAM=$(free -h | grep Mem | awk '{print $2}')
DISKS=$(lsblk -d | awk '{print $1, $4}')
VIDEO=$(lshw -class display | grep "product")

# Gather Network Information
IP=$(hostname -I | awk '{print $1}')
GATEWAY=$(ip r | grep default | awk '{print $3}')
DNS=$(systemd-resolve --status | grep 'DNS Servers' | head -1 | awk '{print $3}')
FQDN=$(hostname -f)

# Gather System Status
USERS=$(who | awk '{print $1}' | sort | uniq)
DISK_SPACE=$(df -h)
PROCESS_COUNT=$(ps -e | wc -l)
LOAD_AVERAGE=$(uptime | awk -F'[a-z]:' '{ print $2}')
MEMORY_ALLOCATION=$(free -h)
LISTENING_PORTS=$(ss -tulwn | grep LISTEN)
UFW_RULES=$(sudo ufw status verbose)

# Print Report

echo "
-------------------------------------------------------------------------------------------------------------------------------------------
System Report generated by $USER, $(date)

System Information
-------------------------------------------------------------------------------------------------------------------------------
Hostname: $HOSTNAME
OS: $OS
Uptime: $UPTIME

Hardware Information
---------------------------------------------------------------------------------------------------------------------------------------
$CPU
Ram: $RAM
Disk(s): $DISKS
Video: $VIDEO

Network Information
------------------------------------------------------------------------------------------------------------------------------------
FQDN: $FQDN
Host Address: $IP
Gateway IP: $GATEWAY
DNS Server: $DNS

System Status
---------------------------------------------------------------------------------------------------------------------------
Users Logged In: $USERS
Disk Space: 
$DISK_SPACE
Process Count: $PROCESS_COUNT
Load Averages: $LOAD_AVERAGE
Memory Allocation: 
$MEMORY_ALLOCATION
Listening Network Ports: 
$LISTENING_PORTS
UFW Rules: 
$UFW_RULES
----------------------------------------------------------------------------------------------------------------------
"

