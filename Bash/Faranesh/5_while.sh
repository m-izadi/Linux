#! /bin/bash
clear
read -s -p "please enter name:  " name
while [ "$name" != mina ];do
        vlc beep2.wav &
    echo -e " \033[33;99;7;102mERROR\033[0m"
    read -s -p "please try again:  " name
    
done
clear
    echo Wellcome $name

while [ "1" == "1" ];do
    sleep 5
    vlc beep.mp3 &
    # Send notif in screen
    # -t time roy safhe mondan midim bar hasb milisaniye (man notify-send )
    notify-send -t 1000 "Welcome to my system"
done

#sudo apt install libnotify-bin