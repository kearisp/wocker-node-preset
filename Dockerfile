ARG NODE_VERSION
FROM node:${NODE_VERSION}-alpine

ARG UID=1000
ARG USER=user

ENV TZ=Europe/Kyiv
ENV APP_PORT=80
ENV PORT=$APP_PORT
ENV NPM_RUN="npm start"
ENV PACKAGE_MANAGER="npm"

VOLUME ["/usr/app"]
WORKDIR /usr/app

COPY ./.wocker/entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk --update --no-cache add busybox-extras bash && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE $PORT

USER $UID

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ${NPM_RUN}
