#!/bin/bash

locale
sudo apt update && sudo apt upgrade
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update && sudo apt upgrade

sudo apt install python3-colcon-common-extensions
sudo apt-get install python swig
sudo apt-get install python-pip

cd ~
#YDLidar-SDK 설치 및 빌드(home에서)
git clone https://github.com/YDLIDAR/YDLidar-SDK.git
cd YDLidar-SDK
mkdir build && cd build
cmake ..
make && sudo make install
sudo apt purge brltty
sudo apt install ros-humble-desktop
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt install ros-humble-ros-base 
sudo apt install ros-humble-serial-driver 
sudo apt install ros-humble-teleop-twist-keyboard 
sudo apt install ros-humble-navigation2 
sudo apt install ros-humble-nav2-bringup 
sudo apt install ros-humble-cartographer 
sudo apt install ros-humble-cartographer-ros 
sudo apt install ros-dev-tools 
udev
ufw


echo "export ROS_DOMAIN_ID=3  #다중 통신 혹은 2번 사용시 다른 번호 사용. (범위는 1~232 내에서 사용)
source ~/ros2_ws/install/setup.bash

# 단축키 모음
alias sai='sudo apt install'
alias cw='cd ~/ros2_ws'
alias cs='cd ~/ros2_ws/src'
alias cb='cd ~/ros2_ws && colcon build --symlink-install'
alias eb='nano ~/.bashrc' 
alias sb='source ~/.bashrc'" >> ~/.bashrc
sb
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/firstbot1/ydlidar_ros2_driver   #for ydlidar X4-pro
git clone https://github.com/firstbot1/jarabot               #for ydlidar X4-pro
#git clone https://github.com/Slamtec/sllidar_ros2.git        #RPlidar A1M8 사용시
#git clone https://github.com/jarabot/jarabot.git             #RPlidar A1M8 사용시
cd ~/ros2_ws
sb && cb
sudo cp ~/ros2_ws/src/jarabot/jarabot_node/rule/99-jarabot.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

sudo ufw enable

sudo ufw allow 1:65535/tcp
sudo ufw allow 1:65535/udp

sudo ufw status
