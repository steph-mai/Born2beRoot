!#bin/bash

#architecture
arch=$(uname -a)

#physical CPU
pCPU=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

#virtual CPU
vCPU=$(grep "processor" /proc/cpuinfo | wc -l)

#RAM available and percentage
total_RAM=$(free -m | grep Mem | awk '{print $2}')
used_RAM=$(free -m | grep Mem | awk '{print $3}')
percentage_RAM=$(free -m | grep Mem | awk '{printf("%.2f%%"), $3 * 100 / $2}')

#disk available and percentage
total_disk=$(df -h | grep "dev" | grep -v "boot" | awk '{disk_t += $2} END {print disk_t}')
used_disk=$(df -h | grep "dev" | grep -v "boot" | awk '{disk_u += $3} END {print disk_u}')
percentage_disk=$(df -h | grep "dev" | grep -v "boot" | awk '{disk_t += $2} {disk_u += $3} END {printf("%.2f%%"), disk_u * 100 / disk_t}'

#charge CPU
cpu_load=$(top -b -n1 | grep "^%Cpu" | xargs | cut -c 9- | awk '{printf("%.1f%%"), $1 + $3}')

#last reboot
lvm_count=$(lsblk | grep "lvm" | wc -l)
lvm_check=$(if [ $lvm_count -eq 0 ]; then echo no; else echo yes; fi)

#active connections
connections=$(ss -ta | grep ESTAB | wc -l)
