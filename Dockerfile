# 
# Create a docker image suitable for day to day use when on client
# sites rather than pollute the OSX Base OS on my laptop.
# Yes this is pretty heavy for a container....
#
FROM centos:7
LABEL maintainer="https://github.com/bourkey"


COPY dev-tools.sh /var/temp/dev-tools.sh
WORKDIR /var/temp
RUN bash dev-tools.sh

WORKDIR /

CMD ["/bin/bash"]


