bat 

    bat /etc/apt/sources.list

exa

    exa -lT /etc/apt

        -l, --long: display extended details and attributes
        -T, --tree: recurse into directories as a tree

dust



zoxide > cat

https://github.com/ajeetdsouza/zoxide

    apt install zoxide

    vim ~/.zshrc
        eval "$(zoxide init zsh)"

gping

https://github.com/orf/gping

    echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
    wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
    sudo apt update
    sudo apt install gping



