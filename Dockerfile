FROM cthulhu666/docker-livehelperchat
MAINTAINER cloudhs@gmail.com

ENV TAG 0.1-alpha

RUN curl -Ls https://github.com/cloudhsiao/livehelperchat/archive/v${TAG}.tar.gz \
  | tar xzf - -C /tmp && rm -rf /app && mv -T /tmp/livehelperchat-${TAG}/lhc_web /app

