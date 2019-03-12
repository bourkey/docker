# 
# Create a docker image suitable for day to day use when on client
# sites rather than pollute the OSX Base OS on my laptop.
# Yes this is pretty heavy for a container....
#
FROM centos:7
LABEL maintainer="https://github.com/bourkey"
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install which openssl git vim mlocate curl sudo unzip file python-devel python-pip python36 python36-devel wget bind-utils
RUN useradd -m -u 501 nbourke
RUN chown nbourke:nbourke /home/nbourke/
RUN echo '%wheel    ALL=(ALL)    NOPASSWD:ALL' > /etc/sudoers.d/wheel
RUN chmod 0440 /etc/sudoers.d/wheel
RUN usermod -G wheel nbourke

# Install the AWS CLI Tools
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/var/tmp/awscli-bundle.zip"
WORKDIR /var/tmp/
RUN unzip awscli-bundle.zip
WORKDIR /var/tmp/awscli-bundle/
RUN /var/tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
RUN rm -f /var/tmp/awscli-bundle.zip
RUN rm -rf /var/tmp/awscli-bundle

# Install pip
WORKDIR /var/tmp/
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN /usr/bin/python3.6 get-pip.py

# install kubectl
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN yum -y update
RUN yum -y install kubectl

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get-helm.sh
RUN chmod +x get-helm.sh
RUN bash get-helm.sh

RUN rm -f /bin/python
RUN ln -s /bin/python3.6 /bin/python


WORKDIR /

CMD ["/bin/bash"]


