FROM node:20.20.2-alpine3.23 AS builder
WORKDIR app
COPY *.js .
COPY package.json .
RUN npm install

FROM node:20.20.2-alpine3.23
WORKDIR app
ENV MONGO=true \
    MONGO_URL=mongodb://mongodb:27017/catalogue
COPY --from=builder /app /app
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN chown -R roboshop:roboshop /app
USER roboshop
CMD ["server.js"]
ENTRYPOINT ["node"]





# FROM node:20
# WORKDIR app
# COPY *.js .
# COPY package.json .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node","server.js"]