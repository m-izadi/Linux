#! /bin/bash
echo "Welcome my Frinds , Please select your starting class:
1 - Samurai
2 - Prisoner
3 - Prophet "

read class

case $class in

    1)
        type="Samurai"
        hp=10
        attack=20
        ;;
    2)  
        type="Prisoner"
        hp=20
        attack=4
        ;;

    3)
        type="Prophet"
        hp=30
        attack=4
        ;;
esac

echo "You chosen the $type class. Your HP is $hp and your attack is $attack"







