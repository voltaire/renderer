FROM ubuntu:latest
ARG OVERVIEWER_VERSION=5d61f9a3f777655bb516266aa573c40a1a47d070
ARG MINECRAFT_VERSION=1.16.4

RUN apt-get update && \
    apt-get install -y curl unzip git build-essential python3-pil python3-dev python3-numpy && \
    rm -rf /var/lib/apt/lists/*

ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /root/awscli.zip
RUN unzip /root/awscli.zip && ./aws/install && rm -rf /root/awscli.zip /root/aws

ADD https://overviewer.org/textures/${MINECRAFT_VERSION} /root/.minecraft/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar

ADD https://github.com/overviewer/Minecraft-Overviewer/archive/${OVERVIEWER_VERSION}.zip /root/overviewer.zip
WORKDIR /build
RUN unzip /root/overviewer.zip
WORKDIR /build/Minecraft-Overviewer-${OVERVIEWER_VERSION}
RUN python3 setup.py install && rm -rf /build /root/overviewer.zip
WORKDIR /root

ADD wrapper.sh /wrapper
RUN chmod +x /wrapper
ADD overviewer_cfg.py /overviewer_cfg.py

ENTRYPOINT ["/bin/bash", "/wrapper"]