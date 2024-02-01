#!/bin/bash

# maker: Jun seong Park
# donkey car install on RPi 5

sudo apt-get update --allow-releaseinfo-change
sudo apt-get upgrade

python3 -m venv env --system-site-packages
echo "source ~/env/bin/activate" >> ~/.bashrc
source ~/.bashrc
sudo apt install libcap-dev
mkdir projects
cd projects
git clone https://github.com/autorope/donkeycar
cd donkeycar
git checkout main
pip install -e .[pi]
pip pybind11
python -c "import tensorflow; print(tensorflow.__version__)"

sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
sudo apt-get install git wget cmake build-essential
sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at
cd ~
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
sudo ./scripts/setup_udev_rules.sh

mkdir build && cd build
cmake ../
make -j4
sudo make install

echo "alias ds='cd 	~/donkey_ws/donkeycar'" >> ~/.bashrc
echo "alias dm='cd ~/mycar'" >> ~/.bashrc
echo "alias dc0='donkey calibrate --channel 0 --bus=1'" >> ~/.bashrc
echo "alias dc1='donkey calibrate --channel 1 --bus=1'" >> ~/.bashrc
echo "alias dca='cd ~/mycar && python manage.py drive'" >> ~/.bashrc
