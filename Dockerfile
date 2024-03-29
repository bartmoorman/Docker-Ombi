FROM bmoorman/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive \
    TARGETOS \
    TARGETARCH

ENV OMBI_PORT=5000

WORKDIR /opt/Ombi

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    jq \
    libicu66 \
 && if [ "${TARGETARCH}" = "amd64" ]; then target=${TARGETOS}-x64; else target=${TARGETOS}-${TARGETARCH}; fi \
 && fileUrl=$(curl --silent --location "https://api.github.com/repos/Ombi-app/Ombi/releases/latest" | jq --arg target ${target} --raw-output '.assets[] | select(.name == $target + ".tar.gz") | .browser_download_url') \
 && curl --silent --location "${fileUrl}" | tar xz \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /config

EXPOSE ${OMBI_PORT}

CMD ["/etc/ombi/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD curl --head --insecure --silent --show-error --fail "http://localhost:${OMBI_PORT}/" || exit 1
