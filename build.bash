#!/bin/bash

# CREDIT: TODO (After permission)

sudo mkdir -p /opt/openvslam-community
sudo chown $(whoami):$(whoami) /opt/openvslam-community

# ---------------------------
## 0. Requirements
# ---------------------------
sudo apt-get update
sudo apt-get install -y build-essential git pkg-config cmake make \
    gcc curl wget unzip \
    libeigen3-dev gfortran libyaml-cpp-dev libgoogle-glog-dev


mkdir ws
pushd ws

# ---------------------------
## 1. Install OpenCV
# ---------------------------

# Find the library
ls /opt/openvslam-community/lib/libopencv_core.so > /dev/null
if [ $? -ne 0 ]  # 0 = found the library, 1 = error
then
    # [0] Requirements
    sudo apt-get install -y libgtk-3-dev libavresample-dev libavutil-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
        gfortran openexr libatlas-base-dev python3-dev python3-numpy \
        libtbb2 libtbb-dev libdc1394-22-dev ffmpeg

    # [1] Make a directory
    mkdir build
    pushd build

    # [2] Get the source
    VERSION=4.4.0

    wget -O opencv.tar.gz https://github.com/opencv/opencv/archive/$VERSION.tar.gz
    wget -O opencv_contrib.tar.gz https://github.com/opencv/opencv_contrib/archive/$VERSION.tar.gz

    # unpack
    tar xf opencv.tar.gz
    tar xf opencv_contrib.tar.gz

    # [3] Build Makefile
    mkdir -p opencv-$VERSION/build
    pushd opencv-$VERSION/build
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=/opt/openvslam-community \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$VERSION/modules \
        -D ENABLE_CXX11=ON \
        -D BUILD_DOCS=OFF \
        -D BUILD_EXAMPLES=OFF \
        -D BUILD_JASPER=OFF \
        -D BUILD_OPENEXR=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_TESTS=OFF \
        -D WITH_EIGEN=ON \
        -D WITH_FFMPEG=ON \
        -D WITH_OPENMP=ON \
        ..

    # [4] Compile the source using the Makefile [3]
    # -j: the number of your processors
    make -j8

    # [5] Install the libraries compiled in [4]
    make install

    # [6] Clean the project
    popd  # the source directory [2]
    popd  # the main directory [1]
    rm -rf build
fi


# ---------------------------
## 2. Install g2o
# ---------------------------

# Find the library
ls /opt/openvslam-community/lib/libg2o_core.so > /dev/null
if [ $? -ne 0 ]  # 0 = found the library, 1 = error
then
    # [0] Requirements
    sudo apt-get install -y libatlas-base-dev libsuitesparse-dev

    # [1] Make a directory
    mkdir build
    pushd build

    # [2] Get the source
    git clone https://github.com/RainerKuemmerle/g2o

    # [3] Build Makefile
    mkdir -p g2o/build
    pushd g2o/build
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=/opt/openvslam-community \
        -D CMAKE_CXX_FLAGS=-std=c++11 \
        -D BUILD_SHARED_LIBS=ON \
        -D BUILD_UNITTESTS=OFF \
        -D BUILD_WITH_MARCH_NATIVE=OFF \
        -D G2O_USE_CHOLMOD=OFF \
        -D G2O_USE_CSPARSE=ON \
        -D G2O_USE_OPENGL=OFF \
        -D G2O_USE_OPENMP=ON \
        ..

    # [4] Compile the source using the Makefile [3]
    # -j: the number of your processors
    make -j8

    # [5] Install the libraries compiled in [4]
    make install

    # [6] Clean the project
    popd  # the source directory [2]
    popd  # the main directory [1]
    rm -rf build
fi


# ---------------------------
## 4. Install Pangolin
# ---------------------------

# Find the library
ls /opt/openvslam-community/lib/libpangolin.so > /dev/null
if [ $? -ne 0 ]  # 0 = found the library, 1 = error
then
    # [0] Requirements
    sudo apt-get install -y libgl1-mesa-dev libglew-dev

    # [1] Make a directory
    mkdir build
    pushd build

    # [2] Get the source
    git clone --branch v0.6 https://github.com/stevenlovegrove/Pangolin.git

    # [3] Build Makefile
    mkdir -p Pangolin/build
    pushd Pangolin/build
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=/opt/openvslam-community \
        ..

    # [4] Compile the source using the Makefile [3]
    # -j: the number of your processors
    make -j8

    # [5] Install the libraries compiled in [4]
    make install

    # [6] Clean the project
    popd  # the source directory [2]
    popd  # the main directory [1]
    rm -rf build
fi


# ---------------------------
## 5. Install OpenVSLAM
# ---------------------------

pushd openvslam/build
if [ $? -ne 0 ]  # 0 = found the library, 1 = error
then
    sudo apt install nlohmann-json3-dev libbackward-cpp-dev
    sudo curl https://raw.githubusercontent.com/badaix/popl/master/include/popl.hpp -o /usr/include/popl.hpp

    # [1] Get the source
    git clone https://github.com/OpenVSLAM-Community/openvslam
    pushd openvslam
    pwd
    git submodule update -i --recursive
    git apply ../../openvslam.patch

    # [2] Build Makefile
    mkdir -p build
    cd build
    cmake \
        -D CMAKE_INSTALL_PREFIX=/opt/openvslam-community \
        -D CMAKE_INSTALL_RPATH=/opt/openvslam-community/lib \
        -D CMAKE_BUILD_WITH_INSTALL_RPATH=ON \
        -D USE_PANGOLIN_VIEWER=ON \
        -D INSTALL_PANGOLIN_VIEWER=ON \
        -D USE_SOCKET_PUBLISHER=OFF \
        -D USE_STACK_TRACE_LOGGER=ON \
        -D BUILD_TESTS=ON \
        -D BUILD_EXAMPLES=ON \
        ..

    # [3] Compile the source using the Makefile [3]
    # -j: the number of your processors
    CPLUS_INCLUDE_PATH=/opt/openvslam-community/include make -j8
    if [ $? -ne 0 ]; then
        exit 1
    fi
    make install
    popd
fi

popd

exit 0
