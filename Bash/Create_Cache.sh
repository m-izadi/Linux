#!/bin/bash

# sudo docker-compose -f /srv/docker-composes/graphhopper.yml up -d


while getopts "l:v" options;do
    case "$options" in
        l)
            HealthCheck="$OPTARG"
            ;;
        v)
            echo -e "this script create new cache an replace to old cache "
            exit ;;
    esac
done
if [ -z $HealthCheck ];then
    read -p " Please enter the Health Check URL : " HealthCheck
fi

################################ Health Check
FAIL_CODE=6
check_status(){
    LRED="\033[1;31m" # Light Red
    LGREEN="\033[1;32m" # Light Green
    NC='\033[0m' # No Color
    # read -p " please enter a Health Check URL : " HealthCheck

    curl -sf "$HealthCheck" > /dev/null

    if [ ! $? = ${FAIL_CODE} ];then
        echo -e "${LGREEN}$HealthCheck is online${NC}"
    else
        echo -e "${LRED}$HealthCheck is down${NC}"
    fi
}
check_status "$HealthCheck"

echo "$HealthCheck"
##############################################



































# input=$1
# if [ -z $input ];then
#     read -p " please enter a name : " input
# fi
# echo " Hello $input "



# curl -sSf http://facebook.com > /dev/null
# #   -s/--silent
# #  -S/--show-error
# #  -f/--fail


# if [ "$STATUSCODE" -ne "200" ]
# then
#     msg="$IP URL: $URL was down at $NOWENTRY"
#     echo "$msg" >> "path/log_$NOWLOG.txt"
#     # send email
#     echo "$msg" | mailx -c "$CCEMAIL" -s "$URL down" "$TOEMAIL"
#     sleep 5m
#     # re-spawn this script.
#     exec "$0"
# fi