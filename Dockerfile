FROM node:16-alpine3.12 as build
LABEL org.opencontainers.image.source https://github.com/SupaStuff/node

RUN apk update \
 && apk add -u --no-cache \
            bash \
            curl \
            git \
            jq \
            less \
            openssh-client \
            vim

ARG USERNAME=node

RUN mkdir -p /home/$USERNAME/workspace/node_modules \
        /home/$USERNAME/.vscode-server/extensions \
        /home/$USERNAME/.vscode-server-insiders/extensions \
 && chown -R $USERNAME \
        /home/$USERNAME/workspace \
        /home/$USERNAME/.vscode-server \
        /home/$USERNAME/.vscode-server-insiders

USER $USERNAME

FROM build as test

RUN set -ex
RUN id -u node
RUN node --version
RUN git --version
RUN jq --version
