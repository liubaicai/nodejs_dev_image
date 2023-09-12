FROM ubuntu:22.04

LABEL liubaicai "liushuai.baicai@hotmail.com"

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && apt-get update && \
    apt-get install -y locales tzdata && \
    locale-gen en_US.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y curl git net-tools iputils-ping vim openssh-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

COPY scripts /scripts/
RUN bash /scripts/install-node.sh && rm /scripts/install-node.sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root/workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
