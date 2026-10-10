#!/usr/bin/env bash

if [[ -z ${CXX} ]] && ! CXX="$(command -v g++ 2>/dev/null || command -v clang++ 2>/dev/null || command -v c++ 2>/dev/null)"
then
    echo "no C++ compiler detected" >&2
    echo "Please install g++/clang++ or export CXX with the name/path of your preferred compiler" >&2
    exit 1
fi

#
# create exec directory if it doesn't exist
mkdir -p ../../../exec

BUILD_RETURN_CODE=0
BUILD_RESULT=succeeded

"${CXX}" -DLINUX -o ../../../exec/anim_to_vtk_linux64_gf ../src/anim_to_vtk.cpp || BUILD_RETURN_CODE=$?

if (( BUILD_RETURN_CODE != 0 ))
then
    BUILD_RESULT=failed
fi

echo " " 
echo "Build ${BUILD_RESULT}"
echo " "
rm -f *.o
exit "${BUILD_RETURN_CODE}"

