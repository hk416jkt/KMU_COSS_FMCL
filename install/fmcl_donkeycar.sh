#!/bin/bash

# maker: Jun seong Park
# donkey car install on RPi 5

sudo apt update && sudo apt upgrade
sudo apt install libffi-dev cmake git
sudo apt-get
wget https://www.python.org/ftp/python/3.9.12/Python-3.9.12.tgz
tar zxf Python-3.9.12.tgz
cd Python-3.9.12
sudo ./configure --enable-optimizations
make -j 4
sudo make install

python3 -m venv env --system-site-packages
echo "source ~/env/bin/activate" >> ~/.bashrc
source ~/.bashrc
sudo apt install libcap-dev
sudo apt-get install libssl-dev
git clone https://github.com/IntelRealSense/librealsense
cd librealsense
mkdir build
cd build
cmake ../ -DBUILD_PYTHON_BINDINGS=TRUE
make -j4
sudo make install #Optional if you want the library to be installed in your system

mkdir donkey_ws
cd donkey_ws
git clone https://github.com/autorope/donkeycar
cd donkeycar
git checkout main

pip install tensorflow
pip install -e .[pi]

python -c "import tensorflow; print(tensorflow.__version__)"

echo "alias ds='cd 	~/donkey_ws/donkeycar'" >> ~/.bashrc
echo "alias dm='cd ~/mycar'" >> ~/.bashrc
echo "alias dc0='donkey calibrate --channel 0 --bus=1'" >> ~/.bashrc
echo "alias dc1='donkey calibrate --channel 1 --bus=1'" >> ~/.bashrc
echo "alias dca='cd ~/mycar && python manage.py drive'" >> ~/.bashrc
