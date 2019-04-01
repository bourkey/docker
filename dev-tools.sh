#! /usr/bin/env bash
# scipt to compress the layers in the dockerfile

yum -y update
yum -y install epel-release
yum -y install which openssl git vim mlocate curl sudo unzip file python-devel python-pip python36 python36-devel wget bind-utils kubectl java

# Install the AWS CLI Tools
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/var/tmp/awscli-bundle.zip"
cd /var/tmp/
unzip awscli-bundle.zip
cd /var/tmp/awscli-bundle/
/var/tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm -f /var/tmp/awscli-bundle.zip
rm -rf /var/tmp/awscli-bundle

# install aws authenticator
cd ~
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator
mv aws-iam-authenticator /usr/bin

# install okta aws 
mkdir ~/.okta
export PREFIX=~/.okta 
bash <(curl -fsSL https://raw.githubusercontent.com/oktadeveloper/okta-aws-cli-assume-role/master/bin/install.sh) -i
touch ~/.okta/config.properties


# Install pip
cd /var/tmp/
curl -O https://bootstrap.pypa.io/get-pip.py
/usr/bin/python3.6 get-pip.py


# install helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get-helm.sh
bash get-helm.sh