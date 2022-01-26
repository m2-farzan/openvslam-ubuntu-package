#!/bin/bash
set -e
pushd ws/openvslam/build/test
make test ARGS="-V"
popd
