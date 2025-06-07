ARG NODE_VERSION=24
ARG IMAGE_VERSION="${NODE_VERSION}-alpine"
FROM node:${IMAGE_VERSION}

LABEL org.wocker.preset="node" \
      org.wocker.version="1.0.3" \
      org.wocker.description="Preset for node projects"

ARG UID=1000

ENV VIRTUAL_PORT=80 \
    TZ=Europe/Kyiv \
    NPM_RUN="npm start" \
    PACKAGE_MANAGER="npm"

COPY --chown=${UID}:${UID} ./.wocker/bin/entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN set -e; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    if grep -q "Alpine" /etc/os-release; then \
        apk --update --no-cache add bash; \
    fi && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

VOLUME ["/usr/app"]
WORKDIR /usr/app
EXPOSE $VIRTUAL_PORT

USER $UID

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash", "-c", "${NPM_RUN}"]
