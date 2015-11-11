# asterisk-docker
Dockerfile for building [Asterisk][github/asterisk] as a base for chan_respoke.

This Dockerfile currently builds Debian "jessie" release with pjsip 2.4.5 (customized
for WebRTC/chan_respoke usage) and Asterisk 13.6.0. It configures Asterisk using the
configs from `asterisk/configs/basic-pbx`, also known as the "Super Awesome Company" 
configs.

## usage

To build this image, just clone the repo and build using docker:

    git clone https://github.com/respoke/asterisk-docker.git
    cd asterisk-docker
    docker build -t asterisk .

More often though, you'll want to use the image built by this repo as a base for your 
own image that needs Asterisk with pjsip. This repo is linked to the Docker hub at 
[respoke/asterisk][dockerhub/asterisk], so you can simply add this to the top of 
your own Dockerfile:

    FROM respoke/asterisk:13

## using environment variables and templates

The entrypoint of this image looks for any Jinja2 templates in `/etc/asterisk/` and
processes them, replacing variables with the environment variable of the same name.
There is only one configuration file templated out by default: `pjsip.conf`. This 
default template allows you to supply the following environment variables to `docker
run` like so: 

    docker run -e DCS_TRUNK_AUTH_USERNAME=myAccountId \
               -e DCS_TRUNK_AUTH_PASSWORD=mySecretPassword \
               asterisk

If you use this image as the base for your own Dockerfile, you can add Jinja2
templates to the `/etc/asterisk/` directory with the file extension `.j2` and they will
also be processed. See the `conf/pjsip.conf.j2` template in this repo for an example, 
and refer to the [Official Jinja2 Template Designer Documentation][] for additional
details on the template syntax.

## repo tags

Docker Hub tags are available for versions of Asterisk >= 13.5.0, as well as minor 
version tags (i.e. `13.5`) that receive all patches to that minor version, and major 
version tags (i.e. `13`). The `latest` tag points to the latest version of Asterisk.

# license

[MIT](https://github.com/respoke/asterisk-docker/blob/master/LICENSE)

[github/asterisk]: https://github.com/asterisk/asterisk
[dockerhub/asterisk]: https://hub.docker.com/r/respoke/asterisk/
[Official Jinja2 Template Designer Documentation]: http://jinja.pocoo.org/docs/dev/templates/
