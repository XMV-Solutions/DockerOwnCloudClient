FROM alpine:edge

MAINTAINER David Koller <david.koller@xmv-solutions.com>

# Install ownCloud-client
#RUN echo -e '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main\n@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
#    apk add --no-cache owncloud-client@testing

# All in One Volume
VOLUME /ownCloudVolume

# Configuration
# RUN ln -s /ownCloudVolume/.netrc ~/.netrc
# ENV OWNCLOUDSERVER 'https://owncloud.xmv-solutions.com'
# ENV CRONPERIOD '*/5 * * * *'

# Start Sync
ADD createSyncCommand.sh /createSyncCommand.sh
ADD sync-exclude.lst /sync-exclude.lst 
CMD /createSyncCommand.sh