FROM ubuntu:xenial
MAINTAINER Swire Chen <idoop@msn.cn>

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list

# 使用的是一键安装包，更改以下版本号升级，仅供测试学习交流用，自己做好数据备份

ENV XUAN_VER=3.3

ARG XUAN_URL=http://dl.cnezsoft.com/xuanxuan/${XUAN_VER}/xxb.${XUAN_VER}.zbox_64.zip

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN apt-get update \
    && apt-get install -y wget php-ldap libpng-dev vim net-tools unzip --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && wget ${XUAN_URL} -O xuan.zip && mv xuan.zip /tmp \
    && chmod +x /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80 3306 11443 11444

ENTRYPOINT ["docker-entrypoint"]
