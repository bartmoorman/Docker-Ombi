FROM bmoorman/ubuntu

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /opt/Ombi

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends curl libunwind8 libicu55 libcurl3 && \
    curl --silent --location "https://ci.appveyor.com/api/projects/tidusjar/requestplex/artifacts/linux.tar.gz" | tar xz && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /data

CMD ["/opt/Ombi/Ombi", "--storage", "/data"]

EXPOSE 5000
