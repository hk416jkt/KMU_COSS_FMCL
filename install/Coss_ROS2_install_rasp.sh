# ROS 2 install sh file
# ROS2 version : humble
# Ubuntu ver. : 22.04

# File name : Coss_ROS2_install.sh

#!/bin/sh
locale
sudo apt update && sudo apt upgrade
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/humble/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $jammy) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update && sudo apt upgrade
sudo apt install git  
sudo apt install net-tools # ifconfg  명령 사용 가능
sudo apt install openssh-server  #ssh 접속 가능

cd ~
#YDLidar-SDK 설치 및 빌드(home에서)
git clone https://github.com/YDLIDAR/YDLidar-SDK.git
cd YDLidar-SDK
mkdir build && cd build
cmake ..
make && sudo make install
sudo apt purge brltty
sudo apt install ros-humble-serial-driver \
ros-humble-teleop-twist-keyboard \
ros-humble-navigation2 \
ros-humble-nav2-bringup \
ros-humble-cartographer \
ros-humble-cartographer-ros \
udev \
ufw

echo "export ROS_DOMAIN_ID=3" >> ~/.bashrc
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/firstbot1/ydlidar_ros2_driver   #for ydlidar X4-pro
git clone https://github.com/firstbot1/jarabot               #for ydlidar X4-pro
#git clone https://github.com/Slamtec/sllidar_ros2.git        #RPlidar A1M8 사용 시
#git clone https://github.com/jarabot/jarabot.git             #RPlidar A1M8 사용 시 
cd ~/ros2_ws
colcon build --symlink-install

sudo cp ~/ros2_ws/src/jarabot/jarabot_node/rule/99-jarabot.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
#ufw가 설치되어 있지 않은 경우에 설치 : sudo apt-get install ufw
sudo ufw enable

sudo ufw allow 1:65535/tcp
sudo ufw allow 1:65535/udp
sudo ufw status 

sudo chmod 666 /dev/ttyUSB0
sudo chmod 666 /dev/ttyUSB1

sudo systemctl status ssh  # SSH 서버 실행 중인지 상태 확인
sudo systemctl start ssh # SSH 서버 실행시키기 
sudo ufw allow 22
sudo ufw allow ssh
sudo ufw status
sudo ufw enable
sudo systemctl restart ssh

sudo reboot

