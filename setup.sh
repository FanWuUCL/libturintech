#!/bin/bash

echo "Please login as a sudo before running the script. Use command sudo -i "

apt-get -y update \
&& DEBIAN_FRONTEND=noninteractive apt install -y iputils-ping libgsl-dev g++ git make zlib1g-dev libssl-dev cmake automake curl unzip libcurl4-openssl-dev git libtool autoconf cmake swig doxygen hugs uwsgi python python2.7-dev python3-pip python-pip lcov libtk-img libpqxx-dev libpq-dev postgresql-server-dev-all libgsl-dev libwebsocketpp-dev \
&& wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.gz \
&& wget https://dl.bintray.com/quantlib/releases/QuantLib-1.14.tar.gz \
&& wget https://vorboss.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz \
&& git clone https://github.com/jedisct1/libsodium \
&& git clone https://github.com/zeromq/libzmq \
&& git clone https://github.com/zeromq/czmq \
&& git clone https://github.com/bingoko/cppzmq \
&& git clone https://github.com/Microsoft/cpprestsdk \
&& git clone https://github.com/Tencent/rapidjson \
&& git clone https://github.com/google/protobuf \
&& tar xfz boost_1_64_0.tar.gz \
&& rm boost_1_64_0.tar.gz \
&& cd boost_1_64_0 \
&& ./bootstrap.sh \
&& ./b2 --without-python --prefix=/usr -j 4 link=shared runtime-link=shared install \
&& cd .. && rm -rf boost_1_64_0 && ldconfig \
&& tar xfz QuantLib-1.14.tar.gz \
&& rm QuantLib-1.14.tar.gz \
&& cd QuantLib-1.14 \
&& ./configure --prefix=/usr --disable-static CXXFLAGS=-O3 \
&& make -j$(nproc) && make check && make install \
&& cd .. && rm -rf QuantLib-1.14 && ldconfig \
&& tar -zxvf ta-lib-0.4.0-src.tar.gz && cd ta-lib && ./configure && make && make install && cd .. \
&& cd libsodium && git checkout 675149b && ./autogen.sh && ./configure && make -j$(nproc) && make install && ldconfig && cd .. \
&& cd libzmq && git checkout d062edd &&./autogen.sh && ./configure && make -j$(nproc) && make install && ldconfig && cd .. \
&& cd czmq && git checkout e305dc2 && ./autogen.sh && ./configure && make -j$(nproc) && make install && ldconfig && cd .. \
&& cd cppzmq && mkdir build && cd build && cmake .. && make -j$(nproc) install && cd ../../ \
&& cd cpprestsdk && git checkout fea848e && cd Release && mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release && make -j$(nproc) && make install && cd ../../../ \
&& cd protobuf/ && git checkout 48cb18e && ./autogen.sh && ./configure && make && make install && ldconfig && cd ../ \
&& cd rapidjson && git checkout f54b0e4 && cd ../ && cp -r rapidjson/include/rapidjson/ /usr/local/include/ && cd rapidjson && mkdir build && cd build && cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INSTALL_PREFIX=/usr -DRAPIDJSON_BUILD_DOC=off -DRAPIDJSON_BUILD_EXAMPLES=off -DRAPIDJSON_BUILD_TESTS=off -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=off .. && make -j$(nproc) && make install && cd ../../ \
&& pip install Flask \
&& rm -rf ta-lib libzmq czmq libsodium cppzmq cpprestsdk/ QuantLib/ rapidjson/ ta-lib-0.4.0* protobuf

