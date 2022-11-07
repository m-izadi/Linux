#!/usr/bin/python3

import os


os.system("iptables -F -t nat")

Number_of_Pools = 14
Number_of_IPs = 14
os.system("iptables -t nat -d 172.16.0.0/12 -A POSTROUTING -j SNAT --to-source 172.16.56.171")

index=0
for i in range(10, 66, 4):
    for j in range(85,99):
        os.system("iptables -t nat -A POSTROUTING -m statistic --mode nth --every " + str(Number_of_Pools*Number_of_IPs - index) + " --packet 0 -j SNAT --to-source 10.154." + str(i) + "."+str(j))
        index=index+1


