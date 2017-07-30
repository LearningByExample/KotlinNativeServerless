#!/usr/bin/env bash
echo "creating base image jamedina/openwhisk-kotlin-native"
docker build -t jamedina/openwhisk-kotlin-native docker/

if [ "$?" -eq "0" ]
then
  echo "pushing jamedina/openwhisk-kotlin-native"
  docker push jamedina/openwhisk-kotlin-native
  if [ "$?" -eq "0" ]
  then
    echo "creating image jamedina/kotlin-native-fibonacci"
    docker build -t jamedina/kotlin-native-fibonacci .
    if [ "$?" -eq "0" ]
    then
      echo "pushing"
      docker push jamedina/kotlin-native-fibonacci
      if [ "$?" -eq "0" ]
      then
        echo "done"
      else
        echo "fail to push fibonacci docker"
      fi
    else
      echo "fail to build fibonacci docker"
    fi
  else
    echo "fail to push base docker"
  fi
else
  echo "fail to build base docker"
fi
