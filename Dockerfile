FROM bmoorman/ubuntu:bionic

ENV OMBI_PORT="5000"

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /opt/Ombi

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    curl \
    jq \
    libcurl4 \
    libicu60 \
    libssl1.0.0 \
    libunwind8 \
 && fileUrl=$(curl --silent --location "https://api.github.com/repos/tidusjar/Ombi/releases/latest" | jq --raw-output '.assets[] | select(.name == "linux.tar.gz") | .browser_download_url') \
 && curl --silent --location "${fileUrl}" | tar xz \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /config

EXPOSE ${OMBI_PORT}

CMD ["/etc/ombi/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD curl --head --insecure --silent --show-error --fail "http://localhost:${OMBI_PORT}/" || exit 1
