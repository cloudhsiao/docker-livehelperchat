FROM cthulhu666/docker-livehelperchat
MAINTAINER cloudhs@gmail.com

ENV TAG 0.2-alpha

RUN apt-get update && apt-get install libapache2-mod-geoip -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -Ls https://github.com/cloudhsiao/livehelperchat/archive/v${TAG}.tar.gz \
  | tar xzf - -C /tmp && rm -rf /app && mv -T /tmp/livehelperchat-${TAG}/lhc_web /app

