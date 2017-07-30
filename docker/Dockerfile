# Dockerfile for runing a openwishk Kotlin native action
FROM openjdk:8-jdk

MAINTAINER Juan Medina <jamedina@gmail.com>

#install kotlin native
RUN git clone --depth 1 https://github.com/JetBrains/kotlin-native.git
WORKDIR kotlin-native
RUN ./gradlew dependencies:update
RUN ./gradlew dist

ENV PATH /kotlin-native/dist/bin:$PATH

#install python
RUN apt-get update
RUN apt-get install python3-setuptools -y
RUN easy_install3 pip
RUN pip3 install --upgrade pip setuptools six
RUN pip3 install --no-cache-dir gevent==1.2.1 flask==0.12

#install c libraries
RUN apt-get update
RUN apt-get install libc-dev -y

#preparing the action proxy
ADD actionProxy/ /actionProxy
WORKDIR /actionProxy
ENV FLASK_PROXY_PORT 8080

CMD ["/bin/bash"]