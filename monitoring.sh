#!/bin/bash

#architecture
arch=$(uname -a)

#physical CPU
cpup=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

#virtual CPU
cpuv=$(grep "processor" /proc/cpuinfo | wc -l)

#RAM available and percentage
total_ram=$(free -m | grep Mem | awk '{print $2}')
used_ram=$(free -m | grep Mem | awk '{print $3}')
percentage_ram=$(free -m | grep Mem | awk '{printf("%.2f%%"), $3 * 100 / $2}')

#disk available and percentage
total_disk=$(df -m | grep "dev" | grep -v "boot" | awk '{disk_t += $2} END {print disk_t}')
used_disk=$(df -m | grep "dev" | grep -v "boot" | awk '{disk_u += $3} END {print disk_u}')
percentage_disk=$(df -m | grep "dev" | grep -v "boot" | awk '{disk_t += $2} {disk_u += $3} END {printf("%.2f%%"), disk_u * 100 / disk_t}')

#charge CPU
cpu_load=$(top -b -n1 | grep "^%Cpu" | xargs | cut -c 9- | awk '{printf("%.1f%%"), $1 + $3}')

#last reboot
lb=$(who -b | xargs | awk '{print $3" "$4}')

#LVM use
lvm_count=$(lsblk | grep "lvm" | wc -l)
lvm_check=$(if [ $lvm_count -eq 0 ]; then echo no; else echo yes; fi)

#active connections
tcp_connections=$(ss -ta | grep ESTAB | wc -l)

#connected users
user_log=$(users | wc -w)

#addresses
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link | grep "link/ether" | awk '{print $2}')

#sudo
sudo_command=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall "#Architecture: $arch
    #CPU physical : $cpup
    #vCPU : $cpuv
    #Memory Usage: $used_ram/${total_ram}MB ($percentage_ram)
    #Disk Usage: $used_disk/${total_disk}Mb ($percentage_disk)
    #CPU load: $cpu_load
    #Last boot: $lb
    #LVM use: $lvm_check
    #Connections TCP : $tcp_connections ESTABLISHED
    #User log: $user_log
    #Network: IP $ip ($mac)
    #Sudo : $sudo_command cmd"
