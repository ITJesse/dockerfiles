FROM node:7.9.0-alpine

ENV NODE_ENV production
ENV VERSION 2.4.2

RUN npm install unblock-netease-music@${VERSION} -g && npm cache clean

EXPOSE 8123

ENTRYPOINT ["unblockneteasemusic"]
CMD ["-h"]
