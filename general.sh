# check if the script is running as root:
sudo bash

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# update sudo:
apt-get update -y
apt-get upgrade -y

# install packages:
apt-get install -y curl
apt-get install -y unzip
apt-get install -y zip
apt install -y awscli

# installing adoptium 17 jre:
apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

apt update
apt install temurin-17-jre -y

# configure aws cli:
aws configure

# download the backup and restore scripts:
curl -O ~/backup.sh https://raw.githubusercontent.com/Kayetic/Server-Setup-Scripts/main/backup.sh
curl -O ~/download-backup.sh https://raw.githubusercontent.com/Kayetic/Server-Setup-Scripts/main/restore.sh
chmod +x ~/backup.sh
chmod +x ~/download-backup.sh