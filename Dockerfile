# Dockerfile for runing a Kotlin native fibonacci action
FROM jamedina/openwhisk-kotlin-native

MAINTAINER Juan Medina <jamedina@gmail.com>

#add basic gradle files
ADD .gradle/ /temp-build/.gradle
ADD gradle/ /temp-build/gradle
ADD build.gradle /temp-build
ADD gradlew /temp-build
ADD gradle.properties /temp-build

#get the compiler
WORKDIR /temp-build
RUN ./gradlew

# add our action code
ADD src/ /temp-build/src
ADD buildCpp.sh /temp-build

#build our action
RUN ./gradlew build

#copy the action as the default OpenWhisk docker actions
RUN mkdir /action
RUN cp /temp-build/build/konan/bin/fibonacci.kexe /action/exec

#clean up
RUN rm -rf /temp-build
RUN rm -rf /kotlin-native

CMD ["/bin/bash", "-c", "cd /actionProxy && python3 -u actionproxy.py"]
