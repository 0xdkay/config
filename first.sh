# change archive from us to kr
sed -i 's/us.archive/kr.archive/g' /etc/apt/sources.list

# update package list
apt-get update

# upgrade before doing
apt-get -y dist-upgrade

# install softwares
apt-get install -y openssl-server openssl-client
apt-get install -y vim

# install apache, mysql, php
apt-get install -y apache2
echo "apache is running on ....."
ifconfig eth0 | grep inet | awk '{ print $2 }'

apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql
mysql_install_db
/usr/bin/mysql_secure_installation

apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
apt-get install -y php5-mysql php5-sqlite php5-common php5-dev

service apache2 restart

# install vsftpd with ftps
apt-get install -y vsftpd
sed -i 's/write_enable=NO/write_enable=YES/g' /etc/vsftpd.conf
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out 

/etc/ssl/private/vsftpd.pem
sed -i 's/rsa_cert_file.*/rsa_cert_file=\/etc\/ssl\/private\/vsftpd.pem/g' /etc/vsftpd.conf
sed -i 's/rsa_private_key_file.*/rsa_private_key_file=\/etc\/ssl\/private\/vsftpd.pem/g' /etc/vsftpd.conf
echo "allow_anon_ssl=NO" >> /etc/vsftpd.conf
echo "force_local_data_ssl=YES" >> /etc/vsftpd.conf
echo "force_local_logins_ssl=YES" >> /etc/vsftpd.conf
echo "ssl_tlsv1=YES" >> /etc/vsftpd.conf
echo "ssl_sslv2=YES" >> /etc/vsftpd.conf
echo "ssl_sslv3=YES" >> /etc/vsftpd.conf
echo "require_ssl_reuse=NO" >> /etc/vsftpd.conf
echo "ssl_ciphers=HIGH" >> /etc/vsftpd.conf
service vsftpd restart

# install rvm
sudo apt-get install -y curl
\curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.1.1


# setup github
ssh-keygen -t rsa -C "insinoa@gmail.com"
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
echo "need to add below public key to github"
cat ~/.ssh/id_rsa.pub
echo -n "press enter when you done..."
read t
ssh -T git@github.com

