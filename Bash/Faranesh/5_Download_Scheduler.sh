#! /bin/bash
clear
read -p "plz inter hour:  " hour
read -p "plz inter min:  " min

date_hour=`date +%H`
date_min=`date +%M`

# echo $date_hour $date_min
sigma_date=$(( date_hour * 60 + date_min ))
echo $sigma_date
sigma_date_input=$(( hour * 60 + min ))
echo $sigma_date_input

while [ $sigma_date != $sigma_date_input ];do
    sleep 5
    date_hour=`date +%H`
    date_min=`date +%M`
    sigma_date=$(( date_hour * 60 + date_min ))
done
#wget https://cdna.p30download.ir/p30dl-tutorial/Artificial.Intelligence.for.Business.Introduction-p30download.com.rar
wget https://yt3.ggpht.com/g8T8e39P6tJl5xkKtSpbGquBzX2C5Z5C2lhGbfy2B7j7O4pj8Xi93NTBXuBD8B0GJ2PJmOi-=s900-c-k-c0x00ffffff-no-rj

#Check Exit Status $? (echo $?) get exit status latest command
if [ "$?" == 0 ];then
    echo $?
    notify-send "Download Complate"
else
    notify-send "Error"

fi