FROM circleci/node:8

RUN mkdir -p ~/.meteor && \
    chown -R circleci:circleci ~/.meteor && \
    curl https://install.meteor.com/ | sh
