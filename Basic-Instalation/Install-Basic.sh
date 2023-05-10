#!/bin/bash
# ZSH / VLC / TMUX / OPENVPN KEEPASS RANGER DOCKER GIT TOMCAT  NGINX MATTERMOST  TELEGRAMDESKTOP SUBLIMETEXT SLACK VSCODE HTOP
LRED="\033[1;31m" # Light Red 
LGREEN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
if (( EUID == 0 )); then
	echo -e "${LRED}You must NOT be root to run this." 1>&2
	exit 1
fi
# prevent root from creating ~/tmp/ by creating it ourself and cause permission problems
# Make .node because in the later versions of npm, it's too stupid to make a folder anymore
mkdir ~/tmp/ ~/.node/

# Set Proxy
	echo ""
	echo "Would you like Set Proxy in Apt? (Default No) (Y/n) "
	read -r apt_proxy
	apt_proxy="${apt_proxy^^}" #toUpperCase
	if [ -z "$apt_proxy" ]; then
		apt_proxy="N"
	fi
	# if [ "$apt_proxy" == "Y" ] ; then
	#     echo ""
	# 	proxy=http://proxy.kavosh.org:808/
	#     echo "Please enter your HttpProxy: "
	#     read -r proxy

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
	fi

# tmux
	echo ""
	echo "Would you like to install tmux? (Default No) (Y/n) "
	read -r tmux
	tmux="${tmux^^}" #toUpperCase
	if [ -z "$tmux" ]; then
		tmux="N"
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
	    echo "Please enter your name (for git): "
	    read -r git_name

	    echo ""
	    echo "Please enter your email (for git): "
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

	if [ "$basic_tools" == "Y" ];then

		echo -e "\n\n${LGREEN}##############################################################################################"
		echo -e "${LGREEN}##########################################  Set Proxy  #######################################"
		echo -e "${LGREEN}##############################################################################################"
	    
		sudo echo 'Acquire::http::Proxy "http://proxy.kavosh.org:808/";' > /etc/apt/apt.conf.d/proxy.conf
	fi


echo -e "\n\n${LGREEN}##############################################################################################"
echo -e "${LGREEN}######################################  Start Installation  ##################################"
echo -e "${LGREEN}##############################################################################################"
	sudo apt update
echo -e "${LGREEN}######################################     basic tools      ##################################${NC}"
	if [ "$basic_tools" == "Y" ];then
	    sudo apt install net-tools vim htop curl traceroute pip bash-completion -y
	fi
echo -e "${LGREEN}######################################         vlc          ##################################${NC}"
	if [ "$vlc" == "Y" ];then
	    sudo apt install vlc -y
	fi
echo -e "${LGREEN}######################################         tmux         ##################################${NC}"
	if [ "$tmux" == "Y" ];then
	    sudo apt install tmux -y
	fi
echo -e "${LGREEN}######################################       openvpn        ##################################${NC}"
	if [ "$openvpn" == "Y" ];then
	    # https://www.cyberciti.biz/faq/howto-setup-openvpn-server-on-ubuntu-linux-14-04-or-16-04-lts/
	    wget https://git.io/vpn -O openvpn-install.sh
	    sudo chmod +x openvpn-install.sh
	    sudo bash openvpn-install.sh
	fi
echo -e "${LGREEN}######################################       KeePass        ##################################${NC}"
	if [ "$keepass" == "Y" ];then
	    # sudo apt-add-repository ppa:jtaylor/keepass
	    # sudo apt-get update && sudo apt-get upgrade
	    sudo apt-get install keepass2 -y
	fi
echo -e "${LGREEN}######################################        ranger        ##################################${NC}"
	if [ "$ranger" == "Y" ];then
	    sudo pip install ranger-fm
	fi
echo -e "${LGREEN}######################################        Docker        ##################################${NC}"
	if [ "$docker" == "Y" ]; then
		sudo apt-get update
		sudo apt-get install -y \
		   ca-certificates \
		   curl \
		   gnupg \
		   lsb-release
		sudo mkdir -p /etc/apt/keyrings
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo \
		  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo chmod a+r /etc/apt/keyrings/docker.gpg
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
	fi

	# if [ "$docker" == "Y" ];then
	#     curl -Sslf https://get.docker.com/ | sudo bash
	# fi
echo -e "${LGREEN}######################################         Git          ##################################${NC}"
	if [ "$Git" == "Y" ];then
	    sudo apt install git -y
	    sudo git config --global user.name "$git_name"
	    sudo git config --global user.email "$git_email"
	fi
echo -e "${LGREEN}######################################         zsh          ##################################${NC}"
        if [ "$zsh" == "Y" ];then
                sudo apt install zsh -y
                sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
                # default shell
                sudo chsh -s /usr/bin/zsh
                chsh -s /usr/bin/zsh
            # sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
            # sudo apt install zsh -y
            # chsh -s $(which zsh)

        fi
echo -e "${LGREEN}######################################        tomcat        ##################################${NC}"
	if [ "$tomcat" == "Y" ]; then
		sudo apt-get install -y tomcat7 tomcat7-admin tomcat7-common tomcat7-docs tomcat7-examples tomcat7-user
	fi
echo -e "${LGREEN}######################################        nginx         ##################################${NC}"
	if [ "$nginx" == "Y" ]; then
		sudo apt-get install -y nginx
	fi
echo -e "${LGREEN}######################################      Mattermost      ##################################${NC}"
	if [ "$Mattermost" == "Y" ];then
	    curl -o- https://deb.packages.mattermost.com/setup-repo.sh | sudo bash
	    sudo apt install mattermost-desktop -y
	    sudo apt upgrade mattermost-desktop -y
	fi
echo -e "${LGREEN}######################################        slack         ##################################${NC}"
	if [ "$slack" == "Y" ];then
	    sudo snap install slack --classic
	fi
echo -e "${LGREEN}######################################   Telegram Desktop   ##################################${NC}"
	if [ "$telegram_desktop" == "Y" ];then
	    sudo snap install telegram-desktop
	fi
echo -e "${LGREEN}######################################     sublimetext      ##################################${NC}"
	if [ "$sublimetext" == "Y" ]; then
	    #sudo wget -O- https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq.gpg
	    #echo 'deb [signed-by=/usr/share/keyrings/sublimehq.gpg] https://download.sublimetext.com/ apt/stable/' | sudo tee /etc/apt/sources.list.d/sublime-text.list
	    #sudo apt install sublime-text -y
	    sudo snap install sublime-text --classic
	fi
echo -e "${LGREEN}######################################        vscode        ##################################${NC}"
	if [ "$vscode" == "Y" ]; then
		sudo apt install software-properties-common apt-transport-https wget -y
		wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
		sudo apt update
		sudo apt install code
		code --version
	fi
######################################################################################################################
# ssh-keygen -t rsa -b 2048 -C "$email" -N "" -f ~/.ssh/id_rsa

if [ "$docker" == "Y" ]; then
	echo "Script Complete. Please log out and log back in to finish Docker configuration."
fi
