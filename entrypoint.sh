#!/bin/bash

# Set git config
if [ ! -z "$GIT_EMAIL" ] && [ ! -z "$GIT_USERNAME" ]; then
    git config --global user.email "$GIT_EMAIL"
    git config --global user.name "$GIT_USERNAME"
fi

# Set correct permissions for SSH files
if [ -d /mnt/.ssh ]; then
    mkdir -p $HOME/.ssh
    cp -r /mnt/.ssh/. $HOME/.ssh/
    chown -R $(id -u):$(id -g) $HOME/.ssh
    chmod 700 $HOME/.ssh
fi

# Initialize and install dependencies if package.json exists
if [ -f package.json ]; then
    npm install
fi

exec "$@"