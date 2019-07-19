#!/bin/bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'


sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt update

sudo apt install -y net-tools terminator

#ros melodic full

sudo apt install -y ros-melodic-desktop-full

sudo rosdep init
rosdep update

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
echo "alias cm='cd ~/catkin_nav && catkin_make'" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential ros-melodic-costmap-2d ros-melodic-social-navigation-layers ros-melodic-map-server

# visual code
wget -O vs_code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install ./vs_code.deb
rm vs_code.deb

#Navigation nuc will be the server
sudo apt install -y chrony ntpdate
#allow to run a local chrony server even if no global ntp server is used
sudo echo "local stratum 10" >> /etc/chrony/chrony.conf
#let users from any local subnet to connect to this machine
sudo echo "allow 192.168.0.0/16" >> /etc/chrony/chrony.conf
#enable chrony at startup
sudo systemctl enable chrony
#and
sudo systemctl restart chrony

#create catkin workspace
mkdir ~/catkin_nav && mkdir ~/catkin_nav/src 
cd ~/catkin_nav && catkin_make
