mkdir DEBIAN/openvslam-community/opt
mv /opt/openvslam-community DEBIAN/openvslam-community/opt/
dpkg-deb --build openvslam-community
