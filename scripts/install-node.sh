#!/usr/bin/bash

NODE_VERSION="18.17.1"
NODE_ARCH=

dpkgArch="$(dpkg --print-architecture)"
case "${dpkgArch##*-}" in 
    amd64) NODE_ARCH='x64';; 
    ppc64el) NODE_ARCH='ppc64le';; 
    s390x) NODE_ARCH='s390x';; 
    arm64) NODE_ARCH='arm64';; 
    armhf) NODE_ARCH='armv7l';; 
    i386) NODE_ARCH='x86';; 
    *) echo "unsupported architecture"; exit 1 ;; 
esac
curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.gz"
tar -zxvf "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.gz" -C /usr/local --strip-components=1 --no-same-owner
rm "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.gz" 
ln -s /usr/local/bin/node /usr/local/bin/nodejs
npm config set registry http://registry.npm.taobao.org 
npm install -g pm2

node -v
