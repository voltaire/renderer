FROM centos:7

ADD https://overviewer.org/rpms/overviewer.repo /etc/yum.repos.d/overviewer.repo
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm unzip
RUN yum install -y Minecraft-Overviewer && yum clean all -y

ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /root/awscli.zip
RUN unzip /root/awscli.zip && ./aws/install && rm /root/awscli.zip /root/aws

ADD https://launcher.mojang.com/v1/objects/1321521b2caf934f7fc9665aab7e059a7b2bfcdf/client.jar /root/.minecraft/versions/1.16.3/1.16.3.jar

ADD wrapper.sh /wrapper
RUN chmod +x /wrapper
ADD overviewer_cfg.py /overviewer_cfg.py

CMD ["/bin/bash", "/wrapper"]