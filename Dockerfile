ARG NODE_VERSION=24
ARG IMAGE_VERSION="${NODE_VERSION}-alpine"
FROM node:${IMAGE_VERSION}

LABEL org.wocker.preset="node" \
      org.wocker.version="1.0.8" \
      org.wocker.description="Preset for node projects"

ARG UID=1000
ARG PACKAGE_MANAGER="npm"

ENV VIRTUAL_PORT=80 \
    TZ="Etc/UTC" \
    NPM_RUN="npm start" \
    PACKAGE_MANAGER="$PACKAGE_MANAGER"

COPY ./.wocker/etc/wocker-build.d /etc/wocker-build.d
COPY ./.wocker/etc/wocker-init.d /etc/wocker-init.d
COPY --chown=${UID}:${UID} ./.wocker/bin/ws-run-hook.sh /usr/local/bin/ws-run-hook
COPY --chown=${UID}:${UID} ./.wocker/bin/entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN set -e; \
    chmod +x /usr/local/bin/ws-run-hook && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ws-run-hook build

VOLUME ["/usr/app"]
WORKDIR /usr/app
EXPOSE $VIRTUAL_PORT

USER $UID

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash", "-c", "${NPM_RUN}"]
