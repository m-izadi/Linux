#! /bin/bash
clear
## Write text in file and owerite
echo "Hello" > newfile.txt
## Write text in line 2 and owerite if not uniq
echo "World" >> newfile.txt
##########
read -p "what is your name:  " name
echo salam $name

############## leason 2
echo -e home: " \033[32;99;7;102m\t  $HOME\033[0m"
echo -e PWD: " \033[33;99;7;102m\t  $PWD\033[0m"
echo -e OSTYPE: " \033[34;99;7;102m$OSTYPE\033[0m"
echo -e shell: " \033[35;99;7;102m  $SHELL\033[0m"
echo -e bash: " \033[36;99;7;102m\t  $BASH\033[0m"
echo -e bash version: " \033[37;99;7;102m\t $BASH_VERSION\033[0m"

if [ "$name" == "ali" ]; then
    echo -e " \033[34;99;7;102m\n\n\nWelcome\n\n\033[0m"
elif [ "$name" == "mina" ]; then
    echo -e " \033[34;99;7;102m\n\n\nTaghirat shoma log mindazad\n\n\033[0m"
else 
    echo -e " \033[35;99;7;102m\n\n\n\tERROR\tGomsho Biron Osgol\n\n\n\033[0m"
    exit
fi

echo Plz 1 second Wait
#mohtawiyat poshe ro namayesh mide
sleep 1
clear
ls
read -p "please enter a directory name:  " directory
if [ -d "/Documents/Git/Linux_Script/Bash/Faranesh/$directory" ]; then
    echo Directory existed
else 
    echo -e "Directori fogh vojod nadarad\nDo you want Create $directory ? (y/n)"
    read answer
    if [ "$answer" == "y" ]; then
        mkdir $directory
    else
        echo bye
        exit
    fi    
fi
