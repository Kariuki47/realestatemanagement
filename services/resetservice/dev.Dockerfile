FROM node:18-alpine

RUN apk --no-cache add build-base python3

WORKDIR /usr/app

COPY package.json .
COPY yarn.lock .
COPY .yarnrc.yml .
COPY .yarn .yarn
COPY services/common services/common
COPY services/resetservice services/resetservice

RUN corepack enable && \
    corepack prepare yarn@stable --activate

RUN yarn workspaces focus @realestatemanagement/resetservice

RUN chown -R node:node /usr/app

USER node

CMD ["yarn", "workspace", "@realestatemanagement/resetservice", "run", "dev"]