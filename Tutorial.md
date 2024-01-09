# FMCL research assignment with Park JS, Seong YW, Seong WC

## 1. 로봇형 자율 주행 플랫폼 셋팅 방법
### 1.1 raspberry pi 설정
16기가 이상의 micro SD 카드를 준비하고, https://www.raspberrypi.com/software/에서 raspberry pi imager를 다운 후 Ubuntu desktop 22.04.3 LTS를 설치.
이후 micro hdmi to hdmi 선을 사용해 모니터와 연결 후 인터넷 연결 하고 초기 설정 후 다음 코드를 사용하여 git을 설치
````
sudo apt update && sudo apt upgrade
sudo apt install git
````
이후 다음 코드로 해당 파일 다운 및 실행
````
git clone https://github.com/hk416jkt/KMU_COSS_FMCL
cd KMU_COSS_FMCL/install
chmod +x Coss_ROS2_install_rasp.sh
./Coss_ROS2_install_rasp.sh
````
재부팅 이후 다음 코드를 통해 라즈베리파이의 주소 파악 및 라이다 및 아두이노 연결 확인
````
ifconfig
ls /dev/my*
````
![image](https://github.com/hk416jkt/KMU_COSS_FMCL/assets/125014941/04c2f6b6-7072-4852-8337-339dd9929fd9)
위 사진과 같이 뜨면 연결 된 것.
안 된 경우 
````
sudo chmod 666 /dev/ttyUSB0 #또는 sudo chmod 666 /dev/mydriver
sudo chmod 666 /dev/ttyUSB1 #또는 sudo chmod 666 /dev/mylidar
````

### 1.2 PC 설정
Ubuntu desktop 환경을 추천하며, 윈도우에서 시도 시 WSL2를 설정 후 하는 것이 필수. 모두 22.04 버전으로 실행하며, 터미널에서 다음과 같은 코드로 git 및 코드 다운을 한다.
````
sudo apt update && sudo apt upgrade
sudo apt install git
git clone https://github.com/hk416jkt/KMU_COSS_FMCL
cd KMU_COSS_FMCL/install
chmod +x PC_install.sh
./PC_install.sh
````

### 1.3 플랫폼 접속
앞서 파악한 라즈베리파이의 주소를 PC에서 사용해 다음과 같이 접속.
```
ssh FMCL_coss@<rasp-ip> # 라즈베리 파이 주소
```
초기 접속시 yes라고 입력 후 비밀번호 입력.(해당 비밀번호는 ubuntu 세팅 시 사용한 비밀번호)





