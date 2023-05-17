#!/bin/bash
# Zsh / Vlc / Tmux / OpenVpn Keepass Ranger Docker Git Tomcat  Nginx Mattermost  TelegramDesktop SublimeText Slack VScode htop
# RED="\033[1;31m" # Light Red 
# GRN="\033[1;32m" # Light Green
# NC='\033[0m' # No Color
RED="\e[31m" ; GRN="\e[32m" ; YLW="\e[33m" ; END="\e[0m"
user=$USER
if (( EUID == 0 )); then
	echo -e "\U1F534 ${RED}You must NOT be root to run this. ${NC}" 1>&2
	exit 1
fi
# prevent root from creating ~/tmp/ by creating it ourself and cause permission problems
# Make .node because in the later versions of npm, it's too stupid to make a folder anymore
mkdir ~/tmp/ ~/.node/

# Set APT Proxy
	echo -e "\nWould you like Set Proxy in Apt? (Default No) (Y/n) "
	read -r apt_proxy
	apt_proxy="${apt_proxy^^}" #toUpperCase
	if [ -z "$apt_proxy" ]; then
		apt_proxy="N"
	fi

	if [ "$apt_proxy" == "Y" ] ; then
	    echo "Please enter your HttpProxy(proxy.kavosh.org?): "
	    read -r proxy
			# proxy="${proxy^^}" #toUpperCase
			if [ -z "$proxy" ]; then
				proxy=proxy.kavosh.org:808
			fi
	fi

# Set WGET Proxy
	echo -e "\nWould you like Set Proxy in wget? (Default No) (Y/n) "
	read -r wget_proxy
	wget_proxy="${wget_proxy^^}" #toUpperCase
	if [ -z "$wget_proxy" ]; then
		wget_proxy="N"
	fi

	if [ "$wget_proxy" == "Y" ] ; then
	    echo "Please enter your HttpProxy(proxy.kavosh.org?): "
	    read -r proxy
			# proxy="${proxy^^}" #toUpperCase
			if [ -z "$proxy" ]; then
				proxy=proxy.kavosh.org:808
			fi
	fi

# Set CURL Proxy
	echo -e "\nWould you like Set Proxy in curl? (Default No) (Y/n) "
	read -r curl_proxy
	curl_proxy="${curl_proxy^^}" #toUpperCase
	if [ -z "$curl_proxy" ]; then
		curl_proxy="N"
	fi
	if [[ "$curl_proxy" == "Y" ]] ; then
	    echo "Please enter your HttpProxy(proxy.kavosh.org?): "
	    read -r curl_url_proxy
			if [ -z "$curl_url_proxy" ]; then
				curl_url_proxy=--proxy http://proxy.kavosh.org:808
			fi
	fi

	# if [[ "$wget_proxy" == "Y" || "$apt_proxy" == "Y" || "$curl_proxy" == "Y" ]] ; then
	#     echo "Please enter your HttpProxy(proxy.kavosh.org?): "
	#     read -r proxy
	# 		proxy="${proxy^^}" #toUpperCase
	# 		if [ -z "$proxy" ]; then
	# 			proxy=proxy.kavosh.org:808
	# 		fi
	# 	curl_proxy=  "\" --proxy http:/$proxy \""
	# fi





# Basic Tools ( net-tools / vim / htop /curl /  )
	echo ""
	echo "Would you like to install Basic Tools? (Default No) (Y/n) "
	read -r basic_tools
	basic_tools="${basic_tools^^}" #toUpperCase
	if [ -z "$basic_tools" ]; then
		basic_tools="N"
	fi

# ZSH
	echo ""
	echo "Would you like to install oh-my-zsh? (Default No) (Y/n) "
	read -r zsh
	zsh="${zsh^^}" #toUpperCase
	if [ -z "$zsh" ]; then
		zsh="N"
	fi

# vlc
	echo ""
	echo "Would you like to install vlc? (Default No) (Y/n) "
	read -r vlc
	vlc="${vlc^^}" #toUpperCase
	if [ -z "$vlc" ]; then
		vlc="N"
	else
		vlc=vlc
	fi

# tmux
	echo ""
	echo "Would you like to install tmux? (Default No) (Y/n) "
	read -r tmux
	tmux="${tmux^^}" #toUpperCase
	if [ -z "$tmux" ]; then
		tmux="N"
	else
		tmux=tmux
	fi

# openvpn
	echo ""
	echo "Would you like to install openvpn? (Default No) (Y/n) "
	read -r openvpn
	openvpn="${openvpn^^}" #toUpperCase
	if [ -z "$openvpn" ]; then
		openvpn="N"
	fi

# keepass
	echo ""
	echo "Would you like to install keepass? (Default No) (Y/n) "
	read -r keepass
	keepass="${keepass^^}" #toUpperCase
	if [ -z "$keepass" ]; then
		keepass="N"
	else
		keepass=keepass
	fi

# ranger
	echo ""
	echo "Would you like to install ranger? (Default No) (Y/n) "
	read -r ranger
	ranger="${ranger^^}" #toUpperCase
	if [ -z "$ranger" ]; then
		ranger="N"
	fi

# Docker
	echo ""
	echo "Would you like to install docker ? (Default No) (Y/n) "
	read -r docker
	docker="${docker^^}" #toUpperCase
	if [ -z "$docker" ]; then
		docker="N"
	fi

# git
	echo ""
	echo "Would you like to install git? (Default No) (Y/n) "
	read -r git
	git="${git^^}" #toUpperCase
	if [ -z "$git" ] ; then
		Git="N"
	fi
	if [ "$git" == "Y" ] ; then
	    echo ""
	    echo "${YLW} Please enter your name (for git): ${NC}"
	    read -r git_name

	    echo ""
	    echo "${YLW} Please enter your email (for git): ${NC}"
	    read -r git_email
	fi

# tomcat
	echo ""
	echo "Would you like to install tomcat? (Default No)(Y/n) "
	read -r tomcat
	tomcat="${tomcat^^}" #toUpperCase
	if [ -z "$tomcat" ]; then
		tomcat="N"
	fi

# nginx
	echo ""
	echo "Would you like to install nginx? (Default No) (Y/n) "
	read -r nginx
	nginx="${nginx^^}" #toUpperCase
	if [ -z "$nginx" ]; then
		nginx="N"
	fi

# Mattermost
	echo ""
	echo "Would you like to install Mattermost? (Default No) (Y/n) "
	read -r Mattermost
	Mattermost="${Mattermost^^}" #toUpperCase
	if [ -z "$Mattermost" ]; then
		Mattermost="N"
	fi

# slack
	echo ""
	echo "Would you like to install slack? (Default No) (Y/n) "
	read -r slack
	slack="${slack^^}" #toUpperCase
	if [ -z "$slack" ]; then
		slack="N"
	fi

# telegram_desktop
	echo ""
	echo "Would you like to install telegram_desktop? (Default No) (Y/n) "
	read -r telegram_desktop
	telegram_desktop="${telegram_desktop^^}" #toUpperCase
	if [ -z "$telegram_desktop" ]; then
		telegram_desktop="N"
	fi

# sublimetext
	echo ""
	echo "Would you like to install sublimetext? (Default No) (Y/n) "
	read -r sublimetext
	sublimetext="${sublimetext^^}" #toUpperCase
	if [ -z "$sublimetext" ]; then
		sublimetext="N"
	fi

# vscode
	echo ""
	echo "Would you like to install vscode? (Default No) (Y/n) "
	read -r vscode
	vscode="${vscode^^}" #toUpperCase
	if [ -z "$vscode" ] ; then
		vscode="N"
	fi

if [ "$apt_proxy" == "Y" ];then

echo -e "\n\n${GRN}##############################################################################################"
echo -e "${GRN}##########################################  Set Proxy  #######################################"
echo -e "${GRN}##############################################################################################"
	sudo touch /etc/apt/apt.conf.d/proxy.conf
	sudo setfacl -Rm u:"$user":rw  /etc/apt/apt.conf.d/proxy.conf
	sudo echo -e "Acquire::http::Proxy \"http://$proxy/\";" > /etc/apt/apt.conf.d/proxy.conf && echo -e "apt Proxy Set Successfully" || echo -e "\U1F534 ${RED}Your user does not have access to /etc/apt/apt.conf.d/proxy.conf \nPlease manually add proxy in /etc/apt/apt.conf.d/proxy.conf \nOR \nSet Permisson${NC}"
fi

if [ "$wget_proxy" == "Y" ];then

	sudo setfacl -Rm u:"$USER":rw  /etc/wgetrc
	sudo echo -e "use_proxy=yes\nhttp_proxy=$proxy" >> /etc/wgetrc && echo -e "wget Proxy Set Successfully" || echo -e "\U1F534 ${RED}Your user does not have access to /etc/wgetrc \nPlease manually add proxy in /etc/wgetrc \nOR \nSet Permisson${NC}"
fi

echo -e "${GRN}#####################${NC} Tasks Started in : ${YLW}$(date "+%Y/%m/%d %H:%M") ${GRN}########################${NC}"
echo -e "\n\n${GRN}##############################################################################################"
echo -e "${GRN}######################################  Start Installation  ##################################"
echo -e "${GRN}##############################################################################################"
	sudo apt update
echo -e "\U231B ${GRN}######################################     basic tools      ##################################${NC}"
	if [ "$basic_tools" == "Y" ];then
	    sudo apt install net-tools vim htop curl traceroute pip bash-completion -y
	fi
echo -e "\U231B ${GRN}######################################     Apt Install      ##################################${NC}"
if [[ $vlc == "vlc" || $tmux == tmux || $keepass == keepass ]];then
	{ sudo apt install $vlc $tmux $keepass -y && echo -e "$vlc $tmux $keepass was Installed " ;} || \
	echo -e "\U1F534 $RED----> $vlc $tmux $keepass installation steps are not done correctly.${NC}"; exit 1
else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
fi

# echo -e "${GRN}######################################         vlc          ##################################${NC}"
# 	if [ "$vlc" == "Y" ];then
# 	    sudo apt install vlc -y
# 	fi

# echo -e "${GRN}######################################         tmux         ##################################${NC}"
# 	if [ "$tmux" == "Y" ];then
# 	    sudo apt install tmux -y
# 	fi
# echo -e "${GRN}######################################       KeePass        ##################################${NC}"
# 	if [ "$keepass" == "Y" ];then
# 	    # sudo apt-add-repository ppa:jtaylor/keepass
# 	    # sudo apt-get update && sudo apt-get upgrade
# 	    sudo apt-get install keepass2 -y
# 	fi
echo -e "\U231B ${GRN}######################################       openvpn        ##################################${NC}"
	if [ "$openvpn" == "Y" ];then
	    # https://www.cyberciti.biz/faq/howto-setup-openvpn-server-on-ubuntu-linux-14-04-or-16-04-lts/
	    wget https://git.io/vpn -O openvpn-install.sh
	    sudo chmod +x openvpn-install.sh
	    sudo bash openvpn-install.sh
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi

echo -e "\U231B ${GRN}######################################        ranger        ##################################${NC}"
	if [ "$ranger" == "Y" ];then
	    sudo pip install ranger-fm
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################        Docker        ##################################${NC}"
	if [ "$docker" == "Y" ]; then
		sudo apt-get update
		sudo apt-get install -y \
		   ca-certificates \
		   curl \
		   gnupg \
		   lsb-release
		sudo mkdir -p /etc/apt/keyrings
		curl -fsSL "$curl_url_proxy" https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo \
		  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo chmod a+r /etc/apt/keyrings/docker.gpg
		sudo apt update
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi

	# if [ "$docker" == "Y" ];then
	#     curl -Sslf "$curl_url_proxy" https://get.docker.com/ | sudo bash
	# fi
echo -e "\U231B ${GRN}######################################         Git          ##################################${NC}"
	if [ "$Git" == "Y" ];then
	    sudo apt install git -y
	    sudo git config --global user.name "$git_name"
	    sudo git config --global user.email "$git_email"
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi

echo -e "\U231B ${GRN}######################################         zsh          ##################################${NC}"
    if [ "$zsh" == "Y" ];then
            sudo apt install zsh -y
            sh -c "$(curl -fsSL "$curl_url_proxy" https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh )"
            # default shell
            sudo chsh -s /usr/bin/zsh
            chsh -s /usr/bin/zsh
        # sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        # sudo apt install zsh -y
        # chsh -s $(which zsh)
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
    fi
echo -e "\U231B ${GRN}######################################        tomcat        ##################################${NC}"
	if [ "$tomcat" == "Y" ]; then
		sudo apt-get install -y tomcat7 tomcat7-admin tomcat7-common tomcat7-docs tomcat7-examples tomcat7-user
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################        nginx         ##################################${NC}"
	if [ "$nginx" == "Y" ]; then
		sudo apt-get install -y nginx
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################      Mattermost      ##################################${NC}"
	if [ "$Mattermost" == "Y" ];then
	    curl -o- "$curl_url_proxy" https://deb.packages.mattermost.com/setup-repo.sh | sudo bash
	    sudo apt install mattermost-desktop -y
	    sudo apt upgrade mattermost-desktop -y
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################        slack         ##################################${NC}"
	if [ "$slack" == "Y" ];then
	    sudo snap install slack --classic
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################   Telegram Desktop   ##################################${NC}"
	if [ "$telegram_desktop" == "Y" ];then
	    sudo snap install telegram-desktop
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################     sublimetext      ##################################${NC}"
	if [ "$sublimetext" == "Y" ]; then
	    #sudo wget -O- https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq.gpg
	    #echo 'deb [signed-by=/usr/share/keyrings/sublimehq.gpg] https://download.sublimetext.com/ apt/stable/' | sudo tee /etc/apt/sources.list.d/sublime-text.list
	    #sudo apt install sublime-text -y
	    sudo snap install sublime-text --classic
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
echo -e "\U231B ${GRN}######################################        vscode        ##################################${NC}"
	if [ "$vscode" == "Y" ]; then
		sudo apt install software-properties-common apt-transport-https wget -y
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
		sudo apt update
		sudo apt install code
		code --version
	else
		echo -e "\U1F4CC ${YLW}This step was skipped${NC}"
	fi
######################################################################################################################
# ssh-keygen -t rsa -b 2048 -C "$email" -N "" -f ~/.ssh/id_rsa
echo -e "\U2705 ${GRN}----> Installation is complete .${NC}\n"
if [ "$docker" == "Y" ]; then
	echo -e "${YLW}Please log out and log back in to finish Docker configuration.${NC}"
fi
