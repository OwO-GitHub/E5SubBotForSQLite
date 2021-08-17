  
FROM golang:alpine AS builder

WORKDIR /root

RUN apk update && apk add git \
    && git clone https://github.com/OwO-GitHub/E5SubBotForSQLite.git \
    && cd E5SubBotForSQLite && go build

FROM alpine:latest

ENV TIME_ZONE=Asia/Shanghai

RUN apk update && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

WORKDIR /root

COPY --from=builder /root/E5SubBotForSQLite/E5SubBotForSQLite /root

CMD [ "/root/E5SubBotForSQLite" ]
