#! /usr/bin/env bash
# scipt to compress the layers in the dockerfile

yum -y update
yum -y install epel-release
yum -y install which openssl git vim mlocate curl sudo unzip file python-devel python-pip python36 python36-devel wget bind-utils
useradd -m -u 501 nbourke
chown nbourke:nbourke /home/nbourke/
echo '%wheel    ALL=(ALL)    NOPASSWD:ALL' > /etc/sudoers.d/wheel
chmod 0440 /etc/sudoers.d/wheel
usermod -G wheel nbourke

# Install the AWS CLI Tools
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/var/tmp/awscli-bundle.zip"
cd /var/tmp/
unzip awscli-bundle.zip
cd /var/tmp/awscli-bundle/
 /var/tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
 rm -f /var/tmp/awscli-bundle.zip
 rm -rf /var/tmp/awscli-bundle

# Install pip
cd /var/tmp/
curl -O https://bootstrap.pypa.io/get-pip.py
/usr/bin/python3.6 get-pip.py

# install kubectl
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
yum -y update
yum -y install kubectl

# install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get-helm.sh
chmod +x get-helm.sh
bash get-helm.sh