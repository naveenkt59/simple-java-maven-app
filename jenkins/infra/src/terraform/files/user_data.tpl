#!/bin/bash
#!/bin/bash
mkfs -t ext4 /dev/xvdf
mkdir /opt/data
mount /dev/xvdf /opt/data
echo" /dev/xvdf  /opt/data ext4 defaults,nofail 0 2" >> /etc/fstab
cd  /home/ec2-user
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo "Installing Tomcat"
cd /opt/data
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz
tar -xvf apache-tomcat-8.5.35.tar.gz
aws s3 cp s3://java-bucket-devops/companyNews.war /opt/data/apache-tomcat-8.5.35/webapps/companyNews.war
sudo amazon-linux-extras install java-openjdk11
sudo chmod +x /opt/data/apache-tomcat-8.5.35/bin/startup.sh /opt/data/apache-tomcat-8.5.35/bin/shutdown.sh
sudo ln -s /opt/data/apache-tomcat-8.5.35/bin/startup.sh /usr/local/bin/tomcatup
sudo ln -s /opt/data/apache-tomcat-8.5.35/bin/shutdown.sh /usr/local/bin/tomcatdown
tomcatup
