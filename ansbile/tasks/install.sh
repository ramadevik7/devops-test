#!/bin/bash
# roles/openssl/files/install.sh

wget https://www.openssl.org/source/openssl-1.0.1g.tar.gz -O /tmp/openssl-1.0.1g.tar.gz

cd /tmp
tar -xvzf openssl-1.0.1g.tar.gz

cd openssl-1.0.1g

./config --prefix=/usr         \
  --openssldir=/etc/ssl \
  --libdir=lib          \
  shared                \
  zlib-dynamic

make install

make clean

cd ..

rm -rf openssl-1.0.1g.tar.gz openssl-1.0.1g/
