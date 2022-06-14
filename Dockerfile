FROM ubuntu:xenial
MAINTAINER Swire Chen <idoop@msn.cn>

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list

# 使用的是一键安装包，更改以下版本号升级，仅供测试学习交流用，自己做好数据备份

ENV XUAN_VER=6.0.beta
ENV XUAN_FILE_NAME=xxb.${XUAN_VER}.bundle.zbox_64.tar.gz

# ARG XUAN_URL=http://dl.cnezsoft.com/xuanxuan/${XUAN_VER}/xxb.${XUAN_VER}.zbox_64.zip
ARG XUAN_URL=https://dl.cnezsoft.com/xuanxuan/${XUAN_VER}/${XUAN_FILE_NAME}


COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apt-get -y update \
    && apt-get install -y wget php-ldap libpng-dev vim net-tools unzip tar --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && wget ${XUAN_URL} --no-check-certificate -O xuan.tar.gz && mv xuan.tar.gz /tmp \
    && chmod +x /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost:11180 -O /dev/null || exit 1

EXPOSE 80 3306 11443 11444

ENTRYPOINT ["docker-entrypoint"]
