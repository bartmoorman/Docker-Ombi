FROM ubuntu:xenial

ENV TZ="America/Denver" \
    LANG="C.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends tzdata curl ca-certificates libunwind8 && \
    mkdir /opt/Ombi && \
    curl --silent --location "https://ci.appveyor.com/api/projects/tidusjar/requestplex/artifacts/linux.tar.gz" | tar xz -C /opt/Ombi && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /data

CMD ["/etc/ombi/start.sh"]

EXPOSE 5000
