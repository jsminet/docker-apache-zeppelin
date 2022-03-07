#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM openjdk:8-jdk-slim-buster
LABEL maintainer="JS Minet"

ARG ZEPPELIN_VERSION master

ENV BUILD_DEPS git tini 
ENV DEBIAN_FRONTEND noninteractive
ENV MAVEN_OPTS -Xmx1024m -Xms512m -XX:MaxPermSize=256m -Djava.awt.headless=true
ENV MAVEN_ARGS -T2 -B -e
ENV MAVEN_PROFILE build-distr,spark-3.1,include-hadoop,hadoop3,spark-scala-2.12,web-angular
# Example with doesn't compile all interpreters
ENV MAVEN_PROJECT !groovy,!submarine,!livy,!hbase,!pig,!file,!flink,!ignite,!kylin

COPY docker-entrypoint.sh /usr/local/bin/

WORKDIR /workspace/zeppelin

# Allow npm and bower to run with root privileges
RUN set -ex && \
    apt-get update && \
    apt-get install -y ${BUILD_DEPS} && \
    echo "unsafe-perm=true" > ~/.npmrc && \
    echo '{ "allow_root": true }' > ~/.bowerrc && \
    git clone --progress --verbose --depth 1 \
              --branch "${ZEPPELIN_VERSION}" https://github.com/apache/zeppelin.git \
              /workspace/zeppelin && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    apt-get -yq autoremove git && \
    rm -rf /var/lib/apt/lists/*
    #mv /workspace/zeppelin/zeppelin-distribution/target/zeppelin-*/zeppelin-* /opt/zeppelin/ && \

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["package"]