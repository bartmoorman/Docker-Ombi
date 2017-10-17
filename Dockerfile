FROM ubuntu:xenial

ENV TZ="America/Denver" \
    LANG="C.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends tzdata wget ca-certificates jq unzip mono-devel && \
    wget --quiet --directory-prefix /tmp "$(wget --quiet --output-document - "https://api.github.com/repos/tidusjar/Ombi/releases" | jq -r '.[0].assets[].browser_download_url')" && \
    unzip -q /tmp/Ombi.zip -d /opt/Ombi && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

CMD ["/etc/ombi/start.sh"]

EXPOSE 3579
