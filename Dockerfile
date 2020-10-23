FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl gnupg unzip && \
    echo 'deb https://overviewer.org/debian ./' >> /etc/apt/sources.list && \
    curl https://overviewer.org/debian/overviewer.gpg.asc | apt-key add - && \
    apt-get update && apt-get -y install minecraft-overviewer && \
    rm -rf /var/lib/apt/lists/*

ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /root/awscli.zip
RUN unzip /root/awscli.zip && ./aws/install && rm -rf /root/awscli.zip /root/aws

ADD https://launcher.mojang.com/v1/objects/1321521b2caf934f7fc9665aab7e059a7b2bfcdf/client.jar /root/.minecraft/versions/1.16.3/1.16.3.jar

ADD wrapper.sh /wrapper
RUN chmod +x /wrapper
ADD overviewer_cfg.py /overviewer_cfg.py

CMD ["/bin/bash", "/wrapper"]