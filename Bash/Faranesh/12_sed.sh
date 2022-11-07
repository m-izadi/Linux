#!/bin/bash
clear
echo "visit this site https://www.grymoire.com/Unix/Sed.html" 
# sed = stream editor = virayshgar jaryan
# man sed
echo "It's sunday" | sed 's/day/night/' 
 # sunnight
echo "day day day day day"|sed 's/day/night/'
 # night day day day day
echo "day day day day day"|sed 's/day/night/g' #g=global
 # night night night night night
echo "day day day day day"|sed 's/day/night/3'
 # day day night day day
echo "day day day day day"|sed 's/day/night/3g'    
 # day day night night night
echo "day day day day day"|sed -e 's/day/night/1' -e 's/day/nihgt/2'      
 # night day nihgt day day

# taghirat ro roye hamon fail save mikone
sed -i 's/ali/mohammad/g' test.txt
# hame bejoz a ta d
sed 's/^[^a-d]/r/' test.txt 

sed -r 's/^[a-d]{3}/r/' test.txt 


# ╰─$ cat test.txt 
# a
# ab
# abc
# abcd
# abcde
# abcdef
# abcdefg
# abcdefgh
# abcdefghy
# 09196744227
# 1bcdefghylmn
# absalam ab

echo "################# .* yani harchi bod #################"
sed 's/^[a-c].*/mina/g' test.txt
echo "################# faghat roye khat dovom anjam mide #################"
sed '2 s/^[a-c].*/mina/g' test.txt
echo "################# az khat aval ta akhar ro anjam mide #################"

sed '/^/,& s/^[a-c].*/mina/g' test.txt
echo "################# be gheir khat sevom ro anjam mide #################"
sed '3 !s/^[a-c].*/mina/g' test.txt

echo "################# delete line 3 #################"
sed '3 d' test.txt
echo "################# delete line 1-3 #################"
sed '1,3 d' test.txt
echo "################# dont  delete line 1-3 #################"
sed '1,3 !d' test.txt
echo "################# khat haiye k khaliye ro hazf mikone #################"
sed '/^$/ d' test.txt


echo "################# khat haiye k avalesh a hast ro hazf mikone   #################"
sed -n '/^[a]/ !p' test.txt
echo "################# lower and higher charecter with I #################"
sed 's/[A-D]/qq/Ig' test.txt
echo "################# khat haiye k khaliye ro hazf mikone #################"

echo "################# khat haiye k khaliye ro hazf mikone #################"

echo "################# khat haiye k khaliye ro hazf mikone #################"

