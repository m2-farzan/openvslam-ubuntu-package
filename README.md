# OpenVSLAM-Community Ubuntu Package

![Test](https://github.com/m2-farzan/openvslam-ubuntu-package/actions/workflows/main.yml/badge.svg?branch=main)

This project builds OpenVSLAM-Community using GitHub Actions so that users can download and install it as a .deb package.
The package currently supports Ubuntu 20.04 (x86_64). We'd really appreciate a contribution that adds ARM support.

## Installation

1. Download .deb file from
**[Here](https://github.com/m2-farzan/openvslam-ubuntu-package/actions?query=branch%3Amain+event%3Apush+is%3Asuccess)
-> Top item in the list (click on its title) -> Artifacts (bottom of the page)**

   *Sorry, GitHub doesn't provide a static URL for latest build artifacts.*

2. Install it using `sudo apt install ./openvslam-ubuntu-package.deb` (Note the leading `./`)

## Contribution

Contribution is welcome. See issues on GitHub for some good first-timer suggestions.

## Credit

This work is based on [this gist](https://gist.github.com/kerryeon/d04aec141b6b7f9c84c9b6d339e11576) from [Ho Kim](https://github.com/kerryeon).
