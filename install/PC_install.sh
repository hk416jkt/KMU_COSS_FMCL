#!/bin/bash

locale # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt update && sudo apt install curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/humble/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
cd ~
#YDLidar-SDK 설치 및 빌드(home에서)
git clone https://github.com/YDLIDAR/YDLidar-SDK.git
cd YDLidar-SDK
mkdir build && cd build
cmake ..
make && sudo make install
# ~/.bashrc에 source /opt/ros/humble/setup.bash 확인
sudo apt purge brltty
sudo apt install ros-humble-serial-driver \
ros-humble-teleop-twist-keyboard \
ros-humble-navigation2 \
ros-humble-nav2-bringup \
ros-humble-cartographer \
ros-humble-cartographer-ros \
udev \
ufw
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=2" >> ~/.bashrc #다중 통신 혹은 2번 사용시 다른 번호 사용. (범위는 1~232 내에서 사용)
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/firstbot1/ydlidar_ros2_driver   #for ydlidar X4-pro
git clone https://github.com/firstbot1/jarabot               #for ydlidar X4-pro
#git clone https://github.com/Slamtec/sllidar_ros2.git        #RPlidar A1M8 사용시
#git clone https://github.com/jarabot/jarabot.git             #RPlidar A1M8 사용시
cd ~/ros2_ws
colcon build --symlink-install
sudo cp ~/ros2_ws/src/jarabot/jarabot_node/rule/99-jarabot.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

sudo ufw enable

sudo ufw allow 1:65535/tcp
sudo ufw allow 1:65535/udp

sudo ufw status
