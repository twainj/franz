FROM node:12.14.1-buster-slim

# Linux dependencies, as prescribed in https://github.com/twainj/franz/blob/master/docs/linux.md
# TODO: build-essential, git and python I'm not sure of, I was chasing bugs when I added them, but never did get a full build
# NOTE: I think it might be better to build from a linux host machine.
RUN mkdir /project && chown node:node /project \
  && apt-get update \
  && apt-get install build-essential -y \
  && apt-get install git -y \
  && apt-get install libx11-dev libxext-dev libxss-dev libxkbfile-dev -y \
  && apt-get install python -y
#  && npm run rebuild
#  && npx lerna bootstrap

#USER node

RUN mkdir -p /project/node_modules

VOLUME /project/node_modules

WORKDIR /project

# TODO: Add package-lock.json. It causes some ENOENT files at the moment.
COPY --chown=node:node package.json lerna.json ./

#RUN npx electron-rebuild
