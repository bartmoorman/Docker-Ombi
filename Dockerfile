FROM bmoorman/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV OMBI_PORT=5000

WORKDIR /opt/Ombi

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    curl \
    jq \
    libicu66 \
 && fileUrl=$(curl --silent --location "https://api.github.com/repos/tidusjar/Ombi.Releases/releases" | jq --raw-output '.[0].assets[] | select(.name == "linux-x64.tar.gz") | .browser_download_url') \
 && curl --silent --location "${fileUrl}" | tar xz \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /config

EXPOSE ${OMBI_PORT}

CMD ["/etc/ombi/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD curl --head --insecure --silent --show-error --fail "http://localhost:${OMBI_PORT}/" || exit 1
