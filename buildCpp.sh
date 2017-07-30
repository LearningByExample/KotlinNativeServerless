#!/usr/bin/env bash
DEPS=$(dirname `type -p konanc`)/../dependencies

if [ x$TARGET == x ]; then
case "$OSTYPE" in
  darwin*)  TARGET=macbook ;;
  linux*)   TARGET=linux ;;
  *)        echo "unknown: $OSTYPE" && exit 1;;
esac
fi

CLANG_linux=$DEPS/clang-llvm-3.9.0-linux-x86-64/bin/clang++
CLANG_macbook=$DEPS/clang-llvm-3.9.0-darwin-macos/bin/clang++

var=CLANG_${TARGET}
CLANG=${!var}

mkdir -p build/clang/

$CLANG -x c -c src/main/cpp/parson/parson.c -o build/clang/parson.bc -emit-llvm || exit 1
