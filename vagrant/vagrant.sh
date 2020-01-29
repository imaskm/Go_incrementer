#!/bin/bash 
set +x
sudo su

if [ $? != 0 ] 
then 
    echo "This script needs sudo access"; 
    exit; 
fi;

check_vbox(){

    vboxmanage --version
    if [ $? != 0 ] 
    then 
        wget https://download.virtualbox.org/virtualbox/6.1.2/VirtualBox-6.1.2-135662-Linux_amd64.run -O  vbox.run
        chmod +x ./vbox.run
        echo "y" | ./vbox.run
        vboxmanage --version
        if [ $? != 0 ] 
        then
            echo "Failed to install virtualbox";
            exit;
        fi
    fi
}

check_vagrant(){

    vagrant --version
    if [ $? != 0 ] 
    then 
        wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_linux_amd64.zip -O vagrant.zip
        unzip vagrant.zip -d /usr/bin/
        vagrant --version
        if [ $? != 0 ] 
        then
            echo "Failed to install vagrant";
            exit;
        fi
    fi
    
}

mkdir -p /usr/bin/
check_vbox
check_vagrant 

vagrant init ubuntu/trusty64

vagrant up --provider virtualbox

if [ $? == 0 ] 
then 
    echo "Ubuntu box set up";
    echo "Run vagrant ssh to access VM"
    exit
else
    echo "Failed while setting up vm"
fi



