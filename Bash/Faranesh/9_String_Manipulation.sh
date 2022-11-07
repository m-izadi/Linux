#!/bin/bash
sigmaTime(){
    hour=$1
    minuts=$2
    hour=${hour#0}
    minuts=${minuts#0}
    echo $(( $hour * 60 + $minuts ))

 }

data(){
    data_hour=`date +%H`
    data_minuts=`date +%M`
    sigma_date=`sigmaTime $data_hour $data_minuts`
}

# echo `date +%H:%M`

# start_time_hour_input="15"
# start_time_minuts_input="45"
# end_time_hour_input="15"
# end_time_minuts_input="46"
# link="https://cdna.p30download.ir/p30dl-software/Dont.Sleep.v8.81.x64_p30download.com.rar"

data
echo $sigma_date