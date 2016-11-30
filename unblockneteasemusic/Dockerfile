FROM node:7.2.0-alpine

ENV NODE_ENV production

RUN npm install unblock-netease-music -g && npm cache clean

EXPOSE 8123

ENTRYPOINT ["unblockneteasemusic"]
CMD ["-h"]
