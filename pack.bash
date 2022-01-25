#!/bin/bash
set -e
mkdir -p DEBIAN/openvslam-community/opt \
    DEBIAN/openvslam-community/usr/lib/cmake \
    DEBIAN/openvslam-community/usr/bin
cp -r /opt/openvslam-community/lib/cmake/openvslam DEBIAN/openvslam-community/usr/lib/cmake/
cp -r /opt/openvslam-community DEBIAN/openvslam-community/opt/
pushd ws/openvslam/build
ls run_* | xargs -I% cp % ../../../DEBIAN/openvslam-community/usr/bin/openvslam-%
popd
dpkg-deb --build $(pwd)
