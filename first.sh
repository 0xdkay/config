# change archive from us to kr
sudo sed -i 's/us.archive/kr.archive/g' /etc/apt/sources.list

# update package list
sudo apt-get update

# upgrade before doing
sudo apt-get -y dist-upgrade

# install softwares
sudo apt-get install -y vim
sudo apt-get install -y screen
sudo apt-get install -y rng-tools
echo "HRNGDEVICE=/dev/urandom" | sudo tee -a /etc/default/rng-tools > /dev/null

# install apache, mysql, php
sudo apt-get install -y apache2
echo "apache is running on ....."
ifconfig eth0 | grep inet | awk '{ print $2 }'

sudo apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql
sudo mysql_install_db
sudo /usr/bin/mysql_secure_installation

sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
sudo apt-get install -y php5-mysql php5-sqlite php5-common php5-dev

sudo service apache2 restart

# install vsftpd with ftps
sudo apt-get install -y vsftpd
sudo sed -i 's/\#write_enable=.*/write_enable=YES/g' /etc/vsftpd.conf
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
sudo sed -i 's/rsa_cert_file.*/rsa_cert_file=\/etc\/ssl\/private\/vsftpd.pem/g' /etc/vsftpd.conf
sudo sed -i 's/rsa_private_key_file.*/rsa_private_key_file=\/etc\/ssl\/private\/vsftpd.pem/g' /etc/vsftpd.conf
echo "ssl_enable=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "allow_anon_ssl=NO" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "force_local_data_ssl=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "force_local_logins_ssl=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "ssl_tlsv1=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "ssl_sslv2=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "ssl_sslv3=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "require_ssl_reuse=NO" | sudo tee -a /etc/vsftpd.conf > /dev/null
echo "ssl_ciphers=HIGH" | sudo tee -a /etc/vsftpd.conf > /dev/null
sudo service vsftpd restart

# install rvm
sudo apt-get install -y curl
\curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.1.1
rvm use --default ruby-2.1.1@global

# setup github
ssh-keygen -t rsa -C "insinoa@gmail.com"
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
echo "need to add below public key to github"
cat ~/.ssh/id_rsa.pub
echo -n "press enter when you done..."
read t
ssh -T git@github.com

