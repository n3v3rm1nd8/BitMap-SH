#############################################################
###### ES EL MISMO SCRIPT PERO ACTUALIZADO Y CON HILOS ######
#############################################################

#!/bin/bash
export valueID=$(/usr/bin/id -u)
echo
echo '    ____  _ __  __  ___'
echo '   / __ )(_) /_/  |/  /___ _____'
echo '  / __  / / __/ /|_/ / __ `/ __ \'
echo ' / /_/ / / /_/ /  / / /_/ / /_/ /'
echo '/_____/_/\__/_/  /_/\__,_/ .___/'
echo '                        /_/'
echo
echo -e "\t    Powered by @n3v3rm1nd8"
echo
echo -e "\t    Tw: @n3v3r___m1nd"
echo

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"

if [[ ! $valueID -eq 0 ]]; then
    echo
    echo -e "\n${red}[!] This script needs to be run as a privileged user${end}"
    echo
else

trap ctrl_c SIGINT
stty -echo

function ctrl_c(){
    echo -e "\n\n${red}[!] Program interrupted, exiting...${end}" | sed 's/[0-9]\{1,5\}$//'
    stty sane
    exit 1
}


function helpPanel(){
    echo -e "\n${red}[!] Use: '$0 -i <IP>'${end}"
    echo
    echo -e "\n${yellow}-i|--ip:${end} Put the IP target for scan"
    echo
    echo -e "${yellow}-h|--help:${end} Open help guide"
    echo
    echo -e "${yellow}-t|--threads <number>:${end} Set the number of threads (default: 5)"
    exit 1
}

function scanPorts() {
    local start=$1
    local end=$2
    for p in $(/usr/bin/seq $start $end); do
        /bin/bash -c "echo '' > /dev/tcp/$ip/$p" &>/dev/null && echo -e "\r${green}[+] $p open${end}" | sed 's/[0-9]\{1,5\}$//' && echo "" | /usr/bin/nc.traditional -v -w 1 $ip $p 2>&1 | /usr/bin/grep -I -E "open|Connection refused" | /usr/bin/awk '{print $4}' && echo ""
    done
}

ip=""
step=5  # Valor predeterminado de step

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            helpPanel
            ;;
        -i|--ip)
            ip="$2"
            if [[ -z "$ip" ]]; then
                echo -e "${red}[!] Please specify an IPv4${end}"
                exit 1
            else
                shift 2
            fi
            ;;
        -t|--threads)
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                step="$2"
                shift 2
            else
                echo -e "\n${red}[!] Invalid or missing argument for -t|--threads option.${end}"
                helpPanel
            fi
            ;;
        *)
            echo -e "\n${red}[!] Unknown option: '$1'. Use '$0 --help'${end}"
            exit 1
            ;;
    esac
done

if [[ -z "$ip" ]]; then
    echo -e "${red}[!] No parameter specified. Use '$0 --help' to see the options${end}"
    exit 1
fi

if ! /usr/bin/ping -c 1 -w 1 $ip &>/dev/null; then
    echo -e "\n${red}[!] Error, IP address without connection${end}"
else
    count=0
    for (( i = 1; i <= 65535; i+=step )); do
        start=$i
        end=$((i+step-1))
        if [[ $end -gt 65535 ]]; then
            end=65535
        fi
        scanPorts $start $end &
        count=$((count+1))
        if [[ $count -eq "$step" ]]; then
            count=0
            wait
        fi
    done
    wait
fi

fi
