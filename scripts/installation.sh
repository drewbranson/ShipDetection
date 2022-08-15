##Script to install required packages to run ship detection program


sudo apt install cron
sudo systemctl enable cron
sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install default-jre
wget https://download.esa.int/step/snap/8.0/installers/esa-snap_sentinel_unix_8_0.sh
bash esa-snap_sentinel_unix_8_0.sh

