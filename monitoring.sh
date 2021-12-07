#! /bin/sh

printf "#Architecture   : " && hostnamectl | grep -o 'Kernel.*\|Operating System.*\|Architecture.*' | cut -f2- -d':' | tr -d '\n' && echo

printf "#CPU physical   : " && cat /proc/cpuinfo | grep processor | wc -l | tr -d '\n' && echo

printf "#vCPU           : " && cat /proc/cpuinfo | grep processor | wc -l | tr -d '\n' && echo

printf "#Memory Usage   : " && free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3, $2, ($3*100)/$2}' | tr -d '\n'&& echo

printf "#Disk Usage     : " && df -h | awk '$NF=="/"{printf "%s/%s (%s)", $3, $2, $5}' && echo

printf "#CPU load       : " && top -bn1 | grep load | awk '{printf "%.1f%%", $(NF-2)}' && echo

printf "#Last boot      : " && who -b | awk '{printf "%s %s", $(NF-1), $NF}'&& echo

printf "#LVM use        : " && if lsblk | grep -q lvm; then echo yes; else echo no; fi

printf "#Connexions TCP : " && netstat -an | grep ESTABLISHED | wc -l | tr -d '\n' && echo

printf "#User log       : " && who | cut -d ' ' -f 1 | sort -u | wc -l | tr -d '\n' && echo

printf "#Network        : " && hostname -I | awk '{printf "IP %s ", $NF}' | tr -d '\n' && ip link | grep 'link/ether'| awk '{printf "(%s)\n", $2}'

printf "#Sudo           : " && sudo grep 'sudo ' /var/log/sudo/sudo.log | wc -l | tr -d '\n' &&  printf " cmd\n"




# another way for count number of sudo cmds
# printf "#Sudo           : " && history | grep 'sudo' | awk '{printf "%s\n", $2}' | grep 'sudo' | wc -l
