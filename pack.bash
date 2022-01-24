mkdir -p DEBIAN/openvslam-community/opt DEBIAN/openvslam-community/usr/lib/cmake
cp -r /opt/openvslam-community/lib/cmake/openvslam DEBIAN/openvslam-community/usr/lib/cmake/
mv /opt/openvslam-community DEBIAN/openvslam-community/opt/
dpkg-deb --build openvslam-community
