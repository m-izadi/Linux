#! /bin/bash
clear
# find this name in text.txt file
echo "################# find this name in text.txt file #################"
echo "################# grep "ali" text.txt #################"

grep "ali" text.txt

# find bejoz ali in text.txt
echo "################# find bejoz ali in text.txt #################"
echo "################# grep -v ali text.txt #################"
grep -v ali text.txt

# ali chand bar dar in text.txt tekrar shode
echo "################# ali chand bar dar in text.txt tekrar shode #################"
echo "################# grep -c "ali" text.txt #################"
grep -c "ali" text.txt

# line haiye ke ali dar on vojod darad ro ba shomareye line namayesh mide
echo "################# line haiye ke ali dar on vojod darad ro ba shomareye line namayesh mide #################"
echo "################# grep -n "ali" text.txt #################"
grep -n "ali" text.txt

# kochak o bozorg bodar charecter ro dige ahamiyat nemide
echo "################# kochak o bozorg bodar charecter ro dige ahamiyat nemide #################"
echo "################# grep -i "ali" text.txt #################"
grep -i "ali" text.txt

echo "################# khototi k avalesh a hast ro miyare  #################"
echo "################# grep "^[a]" text.txt #################"
grep "^[a]" text.txt

echo "################# khototi k alharesh d hast ro miyare  #################"
echo "################# grep "[d]$" text.txt #################"
grep "[d]$" text.txt

echo "################# kodom khata a daye ya kodomkhata d dare  #################"
echo "################# grep -e "a" -e "d" text.txt #################"
grep -e "a" -e "d" text.txt

echo "################# harja 3 ta a posht sareham bashe ro neshon mide  #################"
echo "################# grep [a\]{3\} text.txt #################"
grep "[a]\{3\}" text.txt
#or
egrep "[a]{3}" text.txt
#or
grep -E "[a]{3}" text.txt
#or
grep "[a][a][a]" text.txt
