FROM circleci/node:8

RUN mkdir -p ~/.meteor && \
    curl https://install.meteor.com/ | sh
