# OpenVSLAM-Community Ubuntu Package

![Test](https://github.com/m2-farzan/openvslam-ubuntu-package/actions/workflows/main.yml/badge.svg?branch=main)
[![Status](https://img.shields.io/static/v1?label=Status&message=WIP&color=1793D1)](https://aur.archlinux.org/packages/ros2-galactic/)

This project builds OpenVSLAM-Community using GitHub Actions so that users can download and install it as a .deb package.
The package currently supports Ubuntu 20.04 (x86_64). We'd really appreciate a contribution that adds ARM support.

## Installation

1. Download .deb file from
**[Here](https://github.com/m2-farzan/openvslam-ubuntu-package/actions?query=branch%3Amain+event%3Apush+is%3Asuccess)
-> Top item in the list (click on its title) -> Artifacts (bottom of the page)**

   *Sorry, GitHub doesn't provide a static URL for latest build artifacts.*

2. Install it using `sudo apt install ./openvslam-ubuntu-package.deb` (Note the leading `./`)

## Usage

The example binaries are prepended with `openvslam-`. So the tutorial command to run a video SLAM becomes:

```
openvslam-run_video_slam -v orb_vocab.fbow -m ./aist_living_lab_1/video.mp4 -c example/aist/equirectangular.yaml --frame-skip 3 --no-sleep --map-db map.msg
```

To build and link code that depends on OpenVSLAM, make sure you use cmake argument `-D CMAKE_PREFIX_PATH=/opt/openvslam-community`. For example, to build openvslam_ros:

```
git clone --branch ros2 --depth 1 https://github.com/OpenVSLAM-Community/openvslam_ros.git
colcon build --cmake-args -DCMAKE_PREFIX_PATH=/opt/openvslam-community -DUSE_PANGOLIN_VIEWER=ON
```

## Other Notes

OpenVSLAM is built with FBoW variant and Pangolin Viewer on.

## Contribution

Contribution is welcome. See issues on GitHub for some good first-timer suggestions.

## Credit

This work is based on [this gist](https://gist.github.com/kerryeon/d04aec141b6b7f9c84c9b6d339e11576) from [Ho Kim](https://github.com/kerryeon).
