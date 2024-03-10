#!/bin/bash

# This script is to install metasploit in debian based operatin system

if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with sudo or as root'
	exit 1
fi

# Updating the debian system
sudo apt update

# Downloading required packages
sudo apt install gpgv2 autoconf bison build-essential postgresql libaprutil1 libgmp3-dev libpcap-dev openssl libpq-dev libreadline6-dev libsqlite3-dev libssl-dev locate libsvn1 libtool libxml2 libxml2-dev libxslt-dev wget libyaml-dev ncurses-dev  postgresql-contrib xsel zlib1g zlib1g-dev curl -y

# changing the directory to Downloads the installation file will be saved here

cd ~/Downloads

# Downloading the installer

# curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
curl -o ~/Downloads/msfinstall https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb
# changing the permissions

chmod 755 ~/Downloads/msfinstall

# starting the install

./~/Downloads/msfinstall
