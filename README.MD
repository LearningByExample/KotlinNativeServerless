## Kotlin Native Serverless
This is a small example illustrating [this blog post](https://juan-medina.com/2017/07/30/kotlin-native-serverless/)
about doing Serverless functions in Native Kotlin.

This is a followup of the [previous version](https://github.com/LearningByExample/KotlinServerless) that was running in the JVM.

You need to have OpenWhisk up and running, then you could create the action to OpenWhisk with:

```shell
$ wsk action create native-fibonacci --docker jamedina/kotlin-native-fibonacci
```

To test the new action just run:

```shell
$ wsk action invoke --result native-fibonacci --param numbers 5
```

This will output something like:

```json
{
  "result": [
      1,
      1,
      2,
      3,
      5
  ]
}
```

If you like to run your acction there is [an script](/build.sh) to create the docker and upload it to [docker hub](https://hub.docker.com/), you need to modify.

You could use [this base image](https://hub.docker.com/r/jamedina/openwhisk-kotlin-native/) to build your own kotlin native serverless functions, follow this [Dockerfile](/Dockerfile) to understand how.

If you want to run the function locally first install kotlin native:

```shell
git clone --depth 1 https://github.com/JetBrains/kotlin-native.git /kotlin-native
cd /kotlin-native
./gradlew dependencies:update
./gradlew dist
export PATH="$PATH:/kotlin-native/dist/bin"
```

Then you could build, from this repository

```shell
gradlew build
```

Then to run the action
```shell
./build/konan/bin/Fibonacci.kexe "{ \"numbers\" : 5 }"
```

This will output something like:

```json
{"result":[1,1,2,3,5]}
```
