#! /bin/bash
clear
echo -e " \033[32;99;7;102m\tWelcome\033[0m"
echo -e "\n"
echo -e " be bazi marg khosh amadid "

read -p "PLIZ enter name:  " name

# if [ "$name" == "erfun" ]; then
#     echo "khosh omadi $name"
# else
#     echo "esm shoma sabt nashode ast"
# fi

case "$name" in
"erfun")
    echo "hi erfun"
;;
 "fateme")
    echo "salam fati"
;;
"yasamin")
    echo "salam yasi"
;;
"ahmad")
    echo "baz in omad"
;;
*)
    echo "ERROR"
esac




