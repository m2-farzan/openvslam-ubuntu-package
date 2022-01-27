#!/bin/bash
set -e
mkdir -p opt usr/lib/cmake usr/bin
cp -r /opt/openvslam-community/lib/cmake/openvslam usr/lib/cmake/
cp -r /opt/openvslam-community opt/
cp ws/openvslam/build/lib/*.so opt/openvslam-community/lib/
pushd ws/openvslam/build
ls run_* | xargs -I% cp % ../../../usr/bin/openvslam-%
popd
rm -rf ws
dpkg-deb --build $(pwd)
