#! /bin/sh

Architecture=$(uname -a)
CPUphysical=$(cat /proc/cpuinfo | grep 'physical id' | wc -l)
vCPU=$(cat /proc/cpuinfo | grep processor | wc -l)
MemoryUsage=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3, $2, ($3 * 100) / $2}')
DiskUsage=$(df -h | awk '$NF=="/"{printf "%s/%s (%s)\n", $3, $2, $5}')
CPUload=$(top -bn1 | grep load | awk '{printf "%.1f%%\n", $(NF-2)}')
Lastboot=$(who -b | awk '{printf "%s %s\n", $(NF-1), $NF}')
LVMuse=$(if lsblk | grep -q lvm; then echo yes; else echo no; fi)
ConnexionsTCP=$(netstat -an | grep ESTABLISHED | wc -l)
Userlog=$(who | awk '{printf "%s\n", $1}' | sort -u | wc -l)
Network=$(hostname -I | awk '{printf "IP %s ", $NF}' | tr -d '\n' && ip link | grep 'link/ether'| awk '{printf "(%s)\n", $2}')
Sudo=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)

wall "
#Architecture    : $Architecture
#CPU physical    : $CPUphysical
#vCPU            : $vCPU
#Memory Usage    : $MemoryUsage
#Disk Usage      : $DiskUsage
#CPU load        : $CPUload
#Last boot       : $Lastboot
#LVM use         : $LVMuse
#Connexions TCP  : $ConnexionsTCP
#User log        : $Userlog
#Network         : $Network
#Sudo            : $Sudo cmd
"


# another way for count number of sudo cmds
#printf "#Sudo           : " && history | grep 'sudo' | awk '{printf "%s\n", $2}' | grep 'sudo' | wc -l
#printf "#Sudo           : " && sudo grep 'sudo ' /var/log/sudo/sudo.log | wc -l | tr -d '\n' | awk '{printf "%d cmd\n", $1}'

#for display architecture:
#Architecture=$(hostnamectl | grep -o 'Kernel.*\|Operating System.*\|Architecture.*' | cut -f2- -d':' | tr -d '\n' && echo)
