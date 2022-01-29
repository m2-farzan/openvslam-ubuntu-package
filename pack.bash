#!/bin/bash
set -e
mkdir -p opt usr/bin
cp -r /opt/openvslam-community opt/
cp ws/openvslam/build/lib/*.so opt/openvslam-community/lib/
pushd ws/openvslam/build
ls run_* | xargs -I% cp % ../../../usr/bin/openvslam-%
popd
shopt -s extglob
shopt -s dotglob
rm -rfv ../openvslam-ubuntu-package/!(opt|usr|DEBIAN)  # redundant relative patch is used for safety
dpkg-deb --build $(pwd)
