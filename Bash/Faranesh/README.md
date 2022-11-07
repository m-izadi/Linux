notify-send khobi
vimtutor


echo hello world\!\!\!

-lt         کوچکتر از       Grate Than
-le         کوچکتر مساوی    Grate equal
-gt         بزگتر از        Grate Than
-ge         بزرگتر مساوی    Great equal
-eq         برابر           equal
-ne or !=   برابر نبود      not equal

exsample:
if [ $number -lt 5 ]; then

_____________________________________________________

if [ -d "/Documents/Git/Linux_Script/Bash/Faranesh/$directory" ]; then
    echo "OK"

-d اگر دایرکتوری موجود بود اوکی بده
! -d اگر دایرکتوری ناموجود بود اوکی بده
-f اگر فایل موجود بود اوکی بده
! -f اگر فایل ناموجود بود اوکی بده

______________________________________________________
# Math
OLD :
echo `expr 2 + 2`
echo `expr 2 "*" 4`
echo `expr 2 / 4`

New:
echo $((2+2))
echo $((2*4))
echo $((2/4))


______________________________________________________




read -s -p "please enter name:  " name
-s hidden character

______________________________________
# While and until
until [ $number == 100 ];do
echo $number
((number++))

done

        OR
while [ $number != 100 ];do
echo $number
((number++))

done
_________________________________________
###
    - $#        tedad argoman haro neshon mide
    - $@        tamam argoman haro yekja farakhoni mikone
    - $*        hameye argoman haro yek argoman dar nazar migire

_________________________________________
Replace charecter
    date=`date +%H:%M`
    echo ${date/:/*}

______________________________________ 
a="mohammad reza 1997 izadi"

#replace space with _
echo ${a// /_}

#remove mohammad
echo ${a#mohammad}
#az m ta akharin d ro hazf mikone o vaghat "i" mimone
echo ${a##m*d}

#az akhar hazf mikone az aval khat nemire jole
echo ${a%a*d}
#pishamad ro bozrgtar dar nazar migire o az akhar hazf mikone
echo ${a%%a*d}


