#!/bin/sh

checkConnection() {
    local WEBSITES_FILE="${1:-websites}"
    local FREQUENCY_SECONDS="${2:-5}"

    # Outer control loop
    printf "%-20s %-30s %-15s %-5s\n" Timestamp Site DNS_RTT TIME_CONNECT
    while true; do
        #Inner control loop
        for SITE in $(cat $WEBSITES_FILE); do
            TIMESTAMP=$(date +%T-%d\-%m\-%y)
            RESULT=$(curl --silent ${SITE} -w "%{time_namelookup}\n%{time_connect}\n" -o /dev/null)
            DNS_RTT=$(echo $RESULT | awk 'FNR==1')
            TIME_CONNECT=$(echo $RESULT | awk 'FNR==2')
            printf "%-20s %-30s %-15s %-5s\n" $TIMESTAMP $SITE $DNS_RTT $TIME_CONNECT
        done
       sleep $FREQUENCY_SECONDS
    done
}

checkConnection $1 $2
