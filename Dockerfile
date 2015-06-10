# -----------------------------------------------------------------------
# btilford/node-server
# GitHub https://github.com/btilford/node-server
# DockerHub https://registry.hub.docker.com/u/btilford/node-server/
#
# Based on official debian:stable and node Docker images
# -----------------------------------------------------------------------
FROM debian:stable

MAINTAINER Ben Tilford <ben@tilford.info>

# Will temporarily need curl to download node binary
RUN apt-get update
RUN apt-get install -y curl

# -----------------------------------------------------------------------
# Taken from joyent's node image (minus all the build deps)
# https://github.com/joyent/docker-node
#
# verify gpg and sha256: http://nodejs.org/dist/v0.10.30/SHASUMS256.txt.asc
# gpg: aka "Timothy J Fontaine (Work) <tj.fontaine@joyent.com>"
# gpg: aka "Julien Gilli <jgilli@fastmail.fm>"
# -----------------------------------------------------------------------
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

ENV NODE_VERSION 0.12.4
ENV NPM_VERSION 2.11.0

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear




# Make sure node / node libs that look for NODE_ENV are in production mode.
ENV NODE_ENV production

# Remove curl, you shouldn't need that on a server.
RUN apt-get remove -y curl

# No assumptions on what the CMD or ENTRYPOINT will be for your app