#!/bin/bash
set -e
mkdir ws
cd ws
git clone --branch 0.2.4 https://github.com/OpenVSLAM-Community/openvslam
cd openvslam
git submodule update -i --recursive
git apply ../../openvslam.patch
git apply ../../test-build.patch
cd test
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/openvslam-community -DBOW_FRAMEWORK=DBoW2 ..
ls test_* | xargs -I% bash -c ./%
