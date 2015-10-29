# asterisk-docker
Dockerfile for building asterisk as a base for chan_respoke.

This Dockerfile currently builds Debian "jessie" release with pjsip 2.4.5 (customized
for WebRTC/chan_respoke usage) and Asterisk 13.5.0.

## usage

To build this image, just clone this repo and build using docker:

    git clone https://github.com/chadxz/asterisk-docker.git
    cd asterisk-docker
    docker build .

More often though, you'll want to use the image built by this repo as a base for your 
own image that needs Asterisk w/ pjsip. This repo is linked to the Docker hub at 
[chadxz/asterisk][], so you can simply add this to the top of your own Dockerfile:

    FROM chadxz/asterisk:13

Other tags available besides `13` are `latest`, `13.5`, and `13.5.0`.

## license

[MIT](https://github.com/chadxz/asterisk-docker/blob/master/README.md)

[chadxz/asterisk]: https://hub.docker.com/r/chadxz/asterisk/

