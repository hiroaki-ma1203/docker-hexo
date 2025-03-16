FROM node:slim

ARG USER_ID
ARG GROUP_ID
ARG USERNAME=node
ARG GROUPNAME=node

WORKDIR /blog

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    git \
    openssh-client \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g hexo-cli

RUN usermod -u $USER_ID $USERNAME \
    && groupmod -g $GROUP_ID $GROUPNAME \
    && chown -R $USER_ID:$GROUP_ID /blog

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER $USERNAME

ENTRYPOINT ["/entrypoint.sh"]