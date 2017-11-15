FROM bmoorman/ubuntu

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /opt/Ombi

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    curl \
    libcurl3 \
    libicu55 \
    libunwind8 \
 && curl --silent --location "https://ci.appveyor.com/api/projects/tidusjar/requestplex/artifacts/linux.tar.gz" | tar xz \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /data

EXPOSE 5000

CMD ["/etc/ombi/start.sh"]
