FROM bmoorman/ubuntu

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /opt/Ombi

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    curl \
    jq \
    libcurl3 \
    libicu55 \
    libunwind8 \
 && jobId=$(curl --silent --location "https://ci.appveyor.com/api/projects/tidusjar/requestplex/branch/DotNetCore" | jq --raw-output '.build.jobs[0].jobId') \
 && curl --silent --location "https://ci.appveyor.com/api/buildjobs/${jobId}/artifacts/linux.tar.gz" | tar xz \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /config

EXPOSE 5000

CMD ["/etc/ombi/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD curl --silent --location --fail http://localhost:5000/ > /dev/null || exit 1
