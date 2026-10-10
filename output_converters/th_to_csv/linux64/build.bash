#!/usr/bin/env bash

if [[ -z ${CC} ]] && ! CC="$(command -v gcc 2>/dev/null || command -v clang 2>/dev/null || command -v cc 2>/dev/null)"
then
    echo "no C compiler detected" >&2
    echo "Please install gcc/clang or export CXX with the name/path of your preferred compiler" >&2
    exit 1
fi

#
# create exec directory if it doesn't exist
mkdir -p ../../../exec

BUILD_RETURN_CODE=0
BUILD_RESULT=succeeded

"${CC}" -DLINUX -o ../../../exec/th_to_csv_linux64_gf ../src/th_to_csv.c || BUILD_RETURN_CODE=$?

if (( BUILD_RETURN_CODE != 0 ))
then
    BUILD_RESULT=failed
fi

echo " " 
echo "Build ${BUILD_RESULT}"
echo " "
rm -f *.o
exit "${BUILD_RETURN_CODE}"

