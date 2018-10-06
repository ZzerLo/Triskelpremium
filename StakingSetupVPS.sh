#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/zabtc/Triskelpremium/releases/download/1.0.0/triskelpremium-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf triskelpremium-1.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 9552/tcp
  
cd
mkdir -p .triskelpremium
echo "staking=1" >> triskelpremium.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> triskelpremium.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> triskelpremium.conf
echo "rpcallowip=127.0.0.1" >> triskelpremium.conf
echo "listen=1" >> triskelpremium.conf
echo "server=1" >> triskelpremium.conf
echo "daemon=1" >> triskelpremium.conf
echo "logtimestamps=1" >> triskelpremium.conf
echo "maxconnections=256" >> triskelpremium.conf
echo "addnode=209.250.233.104" >> triskelpremium.conf
echo "addnode=45.77.82.101" >> triskelpremium.conf
echo "addnode=138.68.167.127" >> triskelpremium.conf
echo "addnode=207.246.86.118" >> triskelpremium.conf
echo "addnode=149.56.4.247" >> triskelpremium.conf
echo "addnode=149.56.4.246" >> triskelpremium.conf
echo "addnode=149.56.4.245" >> triskelpremium.conf
echo "addnode=149.56.4.244" >> triskelpremium.conf
echo "addnode=149.56.4.243" >> triskelpremium.conf
echo "addnode=149.56.4.242" >> triskelpremium.conf
echo "addnode=149.56.4.241" >> triskelpremium.conf
echo "port=9552" >> triskelpremium.conf
mv triskelpremium.conf .triskelpremium

  
cd
./triskelpremiumd -daemon
sleep 30
./triskelpremium-cli getinfo
sleep 5
./triskelpremium-cli getnewaddress
echo "Use the address above to send your TKP coins to this server"
echo "If you found this helpful, please donate TKP to NNq96FUcDRj62vX5CdbNeAFjG3MTYeeeHn"
