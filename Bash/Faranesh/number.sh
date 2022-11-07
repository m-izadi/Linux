#! /bin/bash
clear
echo -e " \033[32;99;7;102m\tWelcome\033[0m"
echo -e "\n"
read -p "PLIZ enter Number:  " number


if [ $((number % 2)) == 0 ]; then
    echo "even"
else
    echo "odd"
fi