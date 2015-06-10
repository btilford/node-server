# node-server
Bare bones Docker image for NodeJS servers 

## Overview

Most of the NodeJS Docker images out there have a bunch of extra dependencies like python, databases, or scm 
pre-installed. This image is intended only include the base OS plus Node and NPM.

## Details

+ Uses [debian:stable](https://registry.hub.docker.com/_/debian/) as the base image.
+ Uses node install from Joyent's [docker-node](https://github.com/joyent/docker-node). _This required **temporarily** 
installing curl_
+ No assumptions on how you will start your application. No `ENTRYPOINT` or `CMD` is defined.
+ Exports `NODE_ENV=production` 
 