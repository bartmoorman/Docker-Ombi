FROM bmoorman/ubuntu

WORKDIR /opt/Ombi

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends wget curl jq unzip mono-devel && \
    wget --quiet --directory-prefix /tmp "$(curl --silent --location "https://api.github.com/repos/tidusjar/Ombi/releases" | jq -r '.[0].assets[].browser_download_url')" && \
    unzip -q /tmp/Ombi.zip && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

CMD ["/etc/ombi/start.sh"]

EXPOSE 3579
