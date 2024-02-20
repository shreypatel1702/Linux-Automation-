#!/bin/bash

# Gather System Information
hostname=$(hostname)
uptime=$(uptime -p)
os=$(source /etc/os-release && echo $PRETTY_NAME)

# Gather Hardware Information
video=$(sudo lshw -class display | grep "product")
cpu=$(sudo lshw -class processor | grep "product" | head -1)
disks=$(lsblk -d | awk '{print $1, $4}')
ram=$(free -h | grep Mem | awk '{print $2}')


# Gather Network Information
fqdn=$(hostname -f)
ip=$(hostname -I | awk '{print $1}')
dns=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
gateway=$(ip r | grep default | awk '{print $3}')



# Gather System Status
users=$(who | awk '{print $1}' | sort | uniq)
disk_space=$(df -h)
memory_allocation=$(free -h)
process_count=$(ps -e | wc -l)
load_average=$(uptime | awk -F'[a-z]:' '{ print $2}')
ufw_rules=$(sudo ufw status verbose)
listening_ports=$(ss -tulwn | grep LISTEN)

# Print Report

echo "
---------------------------------------------------------------------------------------------------------------------------------------------------------
System Report generated by $users, $(date)

System Information
------------------
Hostname: $hostname
OS: $os
Uptime: $uptime

Hardware Information
--------------------------------------------------------------------------------------------------------------------------------------
$cpu
Ram: $ram
Disk(s): $disks
Video: $video

Network Information
--------------------------------------------------------------------------------------------------------------------------------
FQDN: $fqdn
Host Address: $ip
Gateway IP: $gateway
DNS Server: $dns

System Status
------------------------------------------------------------------------------------------------------------
Users Logged In: $users
Disk Space: 
$disk_space
Process Count: $process_count
Load Averages: $load_average
Memory Allocation: 
$memory_allocation
Listening Network Ports: 
$listening_ports
UFW Rules: 
$ufw_rules
---------------------------------------------------------------------------------------------------------------
"
