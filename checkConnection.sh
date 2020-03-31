checkConnection() {
    local WEBSITES_FILE="${1:-websites}"
    local FREQUENCY_SECONDS="${2:-5}"

    # Outer control loop
    printf "%-20s %-30s %-15s\n" Timestamp Site RTT
    while true; do
        #Inner control loop
        for SITE in $(cat $WEBSITES_FILE); do
            TIMESTAMP=$(date +%T-%d\-%m\-%y)
            RESULT=$(curl --silent ${SITE}:443 -w %{time_connect} 2>&1 | tail -n 1)
            printf "%-18s %-30s %-15s\n" $TIMESTAMP $SITE $RESULT
        done
       sleep $FREQUENCY_SECONDS
    done
}

checkConnection $1 $2
