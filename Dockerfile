FROM node:4.4.3-slim
MAINTAINER Aditya Raghuwanshi <adi.version1@gmail.com>

# Install CoffeeScript, Hubot
RUN \
  npm install -g coffee-script hubot yo generator-hubot && \
  rm -rf /var/lib/apt/lists/*

# make user for bot
# yo requires uid/gid 501
RUN groupadd -g 501 hubot && \
  useradd -d /home/hubot -m -u 501 -g 501 hubot

USER hubot
WORKDIR /home/hubot/

ENV HUBOT_OWNER hubot
ENV HUBOT_NAME violetbot
ENV HUBOT_ADAPTER slack
ENV HUBOT_DESCRIPTION A simple helpful robot for Violet Grey

RUN yo hubot --adapter ${HUBOT_ADAPTER} --owner ${HUBOT_OWNER} --name ${HUBOT_NAME} --description ${HUBOT_DESCRIPTION} --defaults --no-insight
COPY external-scripts.json external-scripts.json
COPY package.json package.json

ENTRYPOINT bin/hubot

